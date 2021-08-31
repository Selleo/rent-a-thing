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
        panel "Bookings by item" do
          react_component(
            'ChartPanel',
            title: 'Bookings by item',
            chartConfig: {
              yAxis: { title: { text: 'Days' } },
            },
            series: [
              {
                type: 'pie',
                dataUrl: v1_items_by_booking_number_url
              },
            ]
          )
        end
      end
      column do
        panel "Customers by months" do
          react_component(
            'ChartPanel',
            title: 'Customers by months',
            chartConfig: {
              yAxis: { title: { text: 'Days' } },
            },
            series: [
              {
                type: 'bar',
                dataUrl: v1_created_customers_by_month_url
              },
            ]
          )
        end
      end
    end
  end
end
