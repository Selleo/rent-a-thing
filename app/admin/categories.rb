ActiveAdmin.register Category do
  menu priority: 5

  # ==============
  # ==== FORM ====
  # ==============

  permit_params :name, :description

  index do
    selectable_column
    id_column

    column :name
    column :description

    actions
  end

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
