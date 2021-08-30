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

        panel "Statistics" do
          react_component(
            'ChartPanel',
            title: 'Bookings by item',
            series: [
              {
                type: 'pie',
                dataUrl: v1_bookings_by_item_url
              },
            ]
          )
        end

        panel "Statistics" do
          react_component(
            'ChartPanel',
            title: 'Users per month',
            series: [
              {
                type: 'line',
                dataUrl: v1_users_per_month_url
              },
              {
                type: 'bar',
                dataUrl: v1_new_users_per_month_url
              },
            ]
          )
        end

        panel "Statistics" do
          react_component(
            'ChartPanel',
            title: 'Income per month',
            series: [
              {
                type: 'bar',
                dataUrl: v1_income_per_month_url
              },
            ]
          )
        end
      end
    end
  end
end
