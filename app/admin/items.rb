ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

  # ==============
  # ==== LIST ====
  # ==============

  scope :active, default: true
  scope :archived

  filter :name
  filter :description

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :category
    column :price_per_day
    actions
  end

  # ==============
  # ==== SHOW ====
  # ==============


  show do
    attributes_table do
      row :name
      row :description
      row :archived
      row :category
      row :price_per_day
      row :bookings do |item|
        item.bookings.count
      end

    end

  end

  # ==============
  # ==== FORM ====
  # ==============

  permit_params :name, :description, :category_id, :archived, :price_per_day

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :price_per_day
    end

    actions
  end


end
