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
    end
  end
end
