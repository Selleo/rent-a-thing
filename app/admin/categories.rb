ActiveAdmin.register Category do
  menu priority: 5

  permit_params :name, :description, :foto

  # ==============
  # ==== FORM ====
  # ==============

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :foto, as: :file
      #<%= form.file_field :avatar %>

    end
    f.actions
  end

  # CREATE
  #
  controller do
    def create
      @category = Category.new
      @category.name = params[:category][:name]
      @category.description = params[:category][:description]
      @category.foto.attach(params[:category][:foto])
      @category.save

      redirect_back(fallback_location: root_path)
    end
  end



  #
  #
  # ==============
  # ==== SHOW ====
  # ==============

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :foto do
            image_tag(url_for(category.foto)) if category.foto.present?
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
