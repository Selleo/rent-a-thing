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
    column :archived
    column :category
    column :price_per_day

    actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :archived
          row :price_per_day
          row :category
          row("Number of bookings") { |item| item.bookings.count }
        end

        active_admin_comments
      end

      column do
        panel "History of bookings" do
          table_for item.bookings do
            column :customer
            column :starts_on
            column :ends_on
          end
        end
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
