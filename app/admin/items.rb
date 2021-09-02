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

  permit_params :name, :description, :category_id, :archived, :item_photo

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :item_foto, as: :file
    end

    actions

    controller do
      def create
        @item = Item.new
        @item.name = params[:item][:name]
        @item.description = params[:item][:description]
        @item.category_id = params[:item][:category]
        @item.archived = params[:item][:archived]
        @item.foto.attach(params[:item][:item_photo])
        @item.save

        redirect_back(fallback_location: root_path)
      end
    end
  end



  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :item_photo do
            image_tag(url_for(item.item_photo)) if item.item_photo.present?
          end
        end
        active_admin_comments
      end
    end
  end

end
