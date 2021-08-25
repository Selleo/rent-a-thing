ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

  # ==============
  # ==== LIST ====
  # ==============

  scope :active, default: true
  scope :archived

  filter :name
  filter :description

  # ==============
  # ==== FORM ====
  # ==============

  permit_params :name, :description, :category_id, :archived, :price

  show do
    attributes_table do
      row :name
      row :description
      row :archived
      row :created_at
      row :updated_at
      row :category
      row :price
      row("Booked") do |item|
          item.bookings.count #zlicza liczbę wierszy z kolumny bookings
      end

      end
    end

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :price
    end

    actions
  end
end

      #item.bookings.count
