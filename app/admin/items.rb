ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

  # ==============
  # ==== index ====
  # ==============

   scope :active, default: true
   scope :archived
   filter :name
   filter :description

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :archived
    column :category
    column :price_per_day
    actions
  end

  # ==============
  # ==== show ====
  # ==============

  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
          row :archived
          row :category
          row :price_per_day
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
      input :price_per_day
      input :archived
    end

    actions
  end
end
