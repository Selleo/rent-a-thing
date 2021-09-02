ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

  # ==============
  # ==== LIST ====
  # ==============

  scope :active, default: true
  scope :archived

  filter :name
  filter :description

  permit_params :name, :description, :category_id, :archived

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :photos, as: :file, input_html: {multiple: true}
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
      @item.photos.attach(params[:item][:photos])
      @item.save

      redirect_to(admin_items_path)
    end
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :archived
          row :created_at
          row :category
          row :price_per_day
          row "Photos" do
            ul do
              item.photos.each do |photo|
                li do
                  div do
                    image_tag(url_for(photo))
                  end
                  div do
                    link_to('delete',"/v1/items/#{item.id}/delete_image/#{photo.id}")
                  end
                end
              end
            end
          end
        end

        active_admin_comments
      end
    end
  end
end
