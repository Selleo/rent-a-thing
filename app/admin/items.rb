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
        @item.name = params[:category][:name]
        @item.description = params[:category][:description]
        @item.category_id = params[:category][:category]
        @item.archived = params[:category][:archived]
        @item.foto.attach(params[:category][:foto])
        @item.save

        redirect_back(fallback_location: root_path)
      end
    end
  end
end
