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

  permit_params :name, :description, :category_id, :archived, :image

  # form do |f|
  #   inputs do
  #     input :name
  #     input :description
  #     input :category
  #     input :archived
  #   end

  #   actions
  # end

  show do
    div do
      image_tag item.image
    end
    default_main_content 
  end






  form do |f|
    f.semantic_errors # shows errors on :base
    
    input :name 
    input :description
    input :archived
    # f.inputs          # builds an input field for every attribute

    f.inputs do 
      f.input :image, as: :file
    end  
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end








end
