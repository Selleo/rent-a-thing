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

  permit_params :name, :description, :category_id, :archived #:price_per_day

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
     # input :price_per_day
    end

    actions
  end
end
