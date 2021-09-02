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

  permit_params :name, :description, :category_id, :price, :archived, item_images: []

  controller do
    def create
      @item = Item.new
      @item.name = params[:item][:name]
      @item.description = params[:item][:description]
      @item.category_id = params[:item][:category_id]
      @item.archived = params[:item][:archived]
      @item.price = params[:item][:price]
      @item.item_images.attach(params[:item][:item_images])
      @item.save

      flash[:notice] = 'New item name'
      redirect_to admin_items_path
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
    panel 'Item Details' do
      # if item.image.present?
      #   div do
      #     image_tag item.image
      #   end
      # end

      attributes_table_for item do
        row :name
        row :description
        row :archived
        row :category
        row :price
        row 'Bookings' do |item|
          item.bookings.count
        end
        binding.pry
        row :item_images do
          div do
            item.item_images.each do |img|
              div do
                image_tag url_for(img), size: '200x200'
              end
            end
          end
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
      f.input :item_images, as: :file, input_html: { multiple: true }
    end

    actions
  end
end
