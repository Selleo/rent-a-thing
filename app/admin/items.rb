ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

  permit_params :name, :description, :archived, [:photos]

  controller do
    def create
      # binding.pry

      @item = Item.new
      @item.name = params[:item][:name]
      @item.description = params[:item][:description]
      @item.archived = params[:item][:archived]
      @item.category_id = params[:item][:category_id]
      # params[:item][:photos].each do |photo|
        @item.photos.attach(params[:item][:photos])
      # end

      # binding.pry

      @item.save

      redirect_back(fallback_location: admin_root_path)
    end
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

  permit_params :name, :description, :category_id, :archived

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :photos, as: :file, input_html: { multiple: true }
    end

    actions
  end

  # ========
  # SHOW
  # =======

  show do
    # binding.pry
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :archived
          row :category
          row :price_per_day

            item.photos.each_with_index do |photo, i|
              # binding.pry
              # image_tag(url_for(photo)) if photo.present?
              row "Photo #{i+1}" do
                image_tag(url_for(photo)) if photo.present?
              end
            end
        end
      end
    end
  end
end
