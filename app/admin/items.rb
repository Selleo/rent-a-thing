ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

  member_action :delete_item_image, method: :delete do
    attachment = ActiveStorage::Attachment.find(params[:id])
    attachment.destroy!
    #redirect_to resource_path, notice: "Image deleted"
    redirect_back(fallback_location: "/")
  end

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

  permit_params :name, :description, :category_id, :archived, fotos: []

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :fotos, as: :file, input_html: { multiple: true }
    end
    actions
  end


  controller do
    def create
      @item = Item.new
      @item.name = params[:item][:name]
      @item.description = params[:item][:description]
      @item.category_id = params[:item][:category_id]
      @item.archived = params[:item][:archived]
      @item.fotos.attach(params[:item][:fotos]) 
      @item.save
      
      redirect_back(fallback_location: "/")

    end    
  end

  # ==============
  # ==== SHOW ====
  # ==============

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :archived
          row :created_at
          row :updated_at
          row :price_per_day
          row :fotos do
            item.fotos.map do |foto|
              li do 
                image_tag(url_for(foto)) if foto.present?
                div do
                  link_to "Delete_foto", delete_item_image_admin_item_path(foto), method: :delete
                end
              end
            end
          end
        end
      end
    end
  end

end
