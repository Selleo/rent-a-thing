ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

  controller do
    def create
      create! do |format|
        format.html { redirect_to admin_items_path }
      end
    end
  end

  index do
    id_column
    column :name
    column :description
    column :archived
    column :category
    column :price_per_day
    actions
  end

  scope :active, default: true
  scope :archived

  filter :name
  filter :description

  show do
    attributes_table do
      row :name
      row :description
      row :archived
      row :category
      row :price_per_day
      row :item_booking_count do |item|
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
