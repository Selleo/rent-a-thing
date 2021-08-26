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

  permit_params :name, :description, :category_id, :price, :archived, :image


    controller do
      def create
        create! do |format|
          #{ admin_items_url }
          flash[:notice] = "New item #{ :name }"
          format.html { redirect_to admin_items_path } 
    
        end
      end 
      def update
        update! { admin_items_url } 
      end 
    end 




  index do
    selectable_column
    #if image.present?
    # image_column :image, style: :thumb
    # end

    column "Image" do |item|
     # item.image.image_url
      #image_tag (item.image,width:100,height:80) 
    end

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

      if item.image.present?
        div do
          image_tag item.image
        end
      end

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
      
    f.inputs do 
      f.input :image, as: :file
    end  
      
    actions
  end
end
