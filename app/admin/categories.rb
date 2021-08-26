ActiveAdmin.register Category do
  menu priority: 5

  # ==============
  # ==== FORM ====
  # ==============

  permit_params :name, :description

  # ==============
  # ==== SHOW ====
  # ==============

  index do
    selectable_column
    column :id
    column :name
    column :description
    column :created_at
    actions

  end


  show do
    columns do
      column do
        attributes_table do
          row :name
          row :description
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
  config.comments = false
end
