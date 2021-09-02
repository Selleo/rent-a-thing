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

  permit_params :name, :description, :category_id, :archived, :fotos

  form do |f|
    inputs do
      input :name
      input :description
      input :category
      input :archived
      input :fotos, as: :file
    end

    actions
  end


  controller do
    def create
      @item = Item.new
      binding.pry
      @item.booked_items = params[:item][]
      
  
    end    
  end
end
