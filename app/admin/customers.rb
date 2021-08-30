ActiveAdmin.register Customer do
  menu priority: 3

  # ==============
  # ==== LIST ====
  # ==============

  filter :full_name
  filter :created_at

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone

  show do
    panel 'Customer Details' do
      attributes_table_for customer do
        row :full_name
        row :email
        row :phone
        row('hahaha') { |lol| lol.bookings.first.items.first.id }
      end
    end

    # panel "Bookings" do
    #   table_for resource do
    #     column :name
    #   end
    # endcolumn do

    # panel 'Items' do
    # table_for resource.bookings do
    #   attributes_table_for items do
    #      column :name
    #   end
    # end
    # end
  end

  index do
    selectable_column
    column :id
    column :full_name
    column :email
    column :phone
    actions
  end
end
