ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

  # ==============
  # ==== LIST ====
  # ==============

  scope :active, default: true
  scope :archived

  filter :name
  filter :description

  index do
    selectable_column
    id_column

    column :name
    column :description
    column :archived
    column :category
    column :price_per_day

    actions
  end

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :archived
          row :price_per_day
          row :category
          row("Number of bookings") { |item| item.bookings.count }

          item.item_pictures.each do |picture|
            row("Image") do
              image_tag url_for(picture.image)
            end
          end
        end

        active_admin_comments
      end

      column do
        panel "History of bookings" do
          table_for item.bookings do
            column :customer
            column :starts_on
            column :ends_on
          end
        end
      end
    end
  end

  # ==============
  # ==== FORM ====
  # ==============

  permit_params :name, :description, :category_id, :archived, :price_per_day

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :price_per_day

      has_many(:item_pictures, new_record: 'Add Picture', heading: 'Pictures', allow_destroy: true) do |b|
        if b.object.image.attached?
          image_tag url_for(b.object.image), width: '300px', height: 'auto'
        else
          b.input :image, as: :file
        end
      end
    end

    actions
  end

  controller do
    def create
      create! do
        attributes = params[:item][:item_pictures_attributes]
        attributes.present? && attributes.each do |_index, given_image|
          @item.item_pictures.create(image: given_image[:image])
        end

        redirect_to collection_url and return if resource.valid?
      end
    end

    def update
      update!

      item = Item.find(params[:id])
      params[:item][:item_pictures_attributes].each do |_index, given_image|
        if given_image[:_destroy].to_i.positive?
          item.item_pictures.find(given_image[:id].to_i).destroy
        elsif given_image[:image].present?
          item.item_pictures.create(image: given_image[:image])
        end
      end
    end
  end
end
