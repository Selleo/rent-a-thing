ActiveAdmin.register BookingException do
  menu priority: 6

  actions :all, except: [:edit]

  filter :item
  filter :starts_on
  filter :ends_on

  index do
    selectable_column
    id_column

    column :item
    column :starts_on
    column :ends_on

    actions
  end

  permit_params :starts_on, :ends_on, :item_id

  form do |f|
    inputs do
      input :starts_on
      input :ends_on
      input :item
    end
    actions
  end
end
