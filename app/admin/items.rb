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

<<<<<<< HEAD
  permit_params :name, :description, :category_id, :archived #:price_per_day
=======
  permit_params :name, :description, :category_id, :archived, :price_per_day
>>>>>>> added indexex

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
<<<<<<< HEAD
     # input :price_per_day
=======
      input :price_per_day
>>>>>>> added indexex
    end

    actions
  end
end
