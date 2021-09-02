ActiveAdmin.register Category do
  menu priority: 5

  # ==============
  # ==== FORM ====
  # ==============

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :category_image, as: :file
    end
    f.actions
  end

  controller do
    def create
      @category = Category.new
      @category.name = params[:category][:name]
      @category.description = params[:category][:description]
      @category.category_image.attach(params[:category][:category_image])
      @category.save

      redirect_back(fallback_location: :root_path)
    end
  end

  permit_params :name, :description, :category_image

  # ==============
  # ==== SHOW ====
  # ==============
  index do
    selectable_column
    column :id
    column :name
    column :description
    actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :category_image do
            if category.category_image.present?
              image_tag(url_for(category.category_image))
            elsif text_node('No Image Provided')
            end
          end
        end
      end

      column do
        panel 'Items' do
          table_for resource.items do
            column :name
            column :description
          end
        end
      end
    end
  end
end
