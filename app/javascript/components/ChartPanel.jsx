import React from 'react'
import PropTypes from 'prop-types'
import URI from 'urijs'
import Highcharts from 'highcharts'
import { apiGet } from '../utils/apiHelpers'

export default class ChartPanel extends React.Component {
  constructor(props) {
    super(props)
  }

  componentDidMount = () => {
    this.initChart()

    this.props.series.forEach((seriesConfig, index) => {
      apiGet(this.dataUrlWithFilters(seriesConfig.dataUrl)).then(data => this.addSeries(data, index, seriesConfig))
    })
  }

  addSeries = (data, index, { dataUrl, ...seriesConfig }) => {
    if (seriesConfig.type == 'pie')
    {
      this.chart.addSeries({
        ...seriesConfig,
        index: index,
        data: data.attributes.value.map(el => ({name: el.category, y: el.value}))
      });
    } else {
      this.chart.xAxis[0].setCategories(data.attributes.value.map(el => el.category))
      this.chart.addSeries({
        ...seriesConfig,
        index: index,
        name: data.attributes.name,
        data: data.attributes.value.map(el => el.value)
      });
    }
  }

  initChart = () => {
    let config = {
      ...this.props.chartConfig,
      title: { text: this.props.title },
    }

    this.chart = Highcharts.chart(this.chartWrapperName(), config)
  }

  dataUrlWithFilters = (url) => {
    const uri = URI(url)
    return uri.toString()
  }

  chartWrapperName = () => this.props.title.toLowerCase().replace(' ', '-')

  render() {
    return (
      <div id={this.chartWrapperName()} />
    )
  }
}

ChartPanel.propTypes = {
  chartConfig: PropTypes.object,
  series: PropTypes.array.isRequired,
  filters: PropTypes.array,
  title: PropTypes.string.isRequired,
}
