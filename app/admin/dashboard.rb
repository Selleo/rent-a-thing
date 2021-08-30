ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do


    columns do
      column do
        panel "Booked days by month" do
          react_component(
            'ChartPanel',
            title: 'Booked days by month',
            chartConfig: {
              yAxis: { title: { text: 'Days' } },
            },
            series: [
              {
                type: 'bar',
                dataUrl: v1_booked_days_by_month_url
              },
            ]
          )
        end
      end
      column do
        panel "Number of bikes bookings" do
          react_component(
            'ChartPanel',
            title: 'Number of bikes bookings',
            chartConfig: {
              yAxis: { title: { text: 'Days' } },
            },
            series: [
              {
                type: 'pie',
                dataUrl: v1_booked_bikes_url
              },
            ]
          )
        end
      end
      column do
        panel "New uswers" do
          react_component(
            'ChartPanel',
            title: 'New Users',
            chartConfig: {
              yAxis: { title: { text: 'Days' } },
            },
            series: [
              {
                type: 'bar',
                dataUrl: v1_new_users_url
              },
            ]
          )
        end
      end
      column do
        panel "Earnings" do
          react_component(
            'ChartPanel',
            title: 'Earnings',
            chartConfig: {
              yAxis: { title: { text: 'PLN' } },
              xAxis: { title: { text: 'Months' } },
            },
            series: [
              {
                type: 'area',
                dataUrl: v1_earnings_url
              },
            ]
          )
        end
      end
    end
  end
end
