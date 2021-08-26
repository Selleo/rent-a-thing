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

  permit_params :name, :description, :category_id, :price, :archived


    controller do
      def create
        create! do |format|
          #{ admin_items_url }
          format.html { redirect_to admin_items_path  }
        end
      end 
      def update
        update! { admin_items_url } 
      end 
    end 




  index do
    selectable_column
    column :id
    column :name
    column :description
    column :archived
    column :category
    column :price
    actions
  end
  
  show do
    panel "Item Details" do
      attributes_table_for item do
        row :name
        row :description
        row :archived
        row :category
        row :price
        row "Bookings" do |item|
          item.bookings.count
        end
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
