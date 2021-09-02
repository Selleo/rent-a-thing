ActiveAdmin.register Category do
  menu priority: 5

  permit_params :name, :description, :photo

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :photo, as: :file
    end
    f.actions
  end


  controller do
    def create
      @category = Category.new
      @category.name = params[:category][:name]
      @category.description = params[:category][:description]
      @category.photo.attach(params[:category][:photo])
      @category.save

      redirect_to(admin_categories_path)
    end
  end


  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :photo do
            image_tag(url_for(category.photo)) if category.photo.present?
          end
        end

        active_admin_comments
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
