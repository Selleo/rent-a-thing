ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4

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
    
  permit_params :name, :description, :category_id, :archived, :price_per_day

<<<<<<< HEAD
<<<<<<< HEAD
  permit_params :name, :description, :category_id, :archived #:price_per_day
=======
  permit_params :name, :description, :category_id, :archived, :price_per_day
>>>>>>> added indexex
=======
>>>>>>> removed test

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :price_per_day
<<<<<<< HEAD
>>>>>>> added indexex
=======
>>>>>>> removed test
    end

    actions
  end
end
