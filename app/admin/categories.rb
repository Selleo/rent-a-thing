ActiveAdmin.register Category do
  menu priority: 5

  index do
    selectable_column
    id_column
    column :name
    column :description
    actions
  end

  # ==============
  # ==== FORM ====
  # ==============

  permit_params :name, :description

  # ==============
  # ==== SHOW ====
  # ==============

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
end
