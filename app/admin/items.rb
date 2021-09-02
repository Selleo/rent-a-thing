ActiveAdmin.register Item do
  menu label: 'Inventory', priority: 4


 # controller do
    # member_action :approve, method: :put do
    #   #resource.approve!
    #   redirect_to admin_item_path(resource), notice: "Approved!"
    # end


    #   member_action :delete_item_image, method: :delete do
    #     redirect_to item_path, notice: "skasowano"
    #   end
    
    
      member_action :lock, method: :get do
       # byebug
       # resource.lock!
      
        picture_to_delete = params[:id]
    
        
        aaa = ActiveStorage::Attachment.find(picture_to_delete)
        item = aaa.record
        aaa.destroy
        #,  
        #notice: "Locked! #{params[:id]} "
        redirect_to admin_item_path(item), notice: "Deleted! #{params[:id]} "
      end



 # end

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

  permit_params :name, :description, :category_id, :archived, :avatar, images: []


  show do
    div do
      ul do
        item.images.each do |img|
          li do 
            image_tag img
            
          end
          li do 
           # byebug
            link_to 'Delete', lock_admin_item_path(img.id)
          end
        end
       end     
    end
    div do
      image_tag item.avatar if item.avatar.present?
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
      f.input :avatar, as: :file
      f.input :images, as: :file, input_html: { multiple: true }
     # f.input :images, as: :file, multiple: true
    end  
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end
