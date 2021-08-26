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

  show do
    columns do
      column do
        attributes_table do
          row :id
          row :name
          row :description
          row :archived
          row :created_at
          row :updated_at
          row :category
          row :price_per_day
        end

        active_admin_comments
      end

      column do
        panel 'Bookings of this item' do
          table_for resource.bookings do
            column :starts_on
            column :ends_on
            column :customer
          end
        end
      end
    end
  end

  # Redirect to to item#index after creating an item
  controller do
    def create
      super do |format|
        redirect_to collection_url and return if resource.valid?
      end
    end
  end
end
