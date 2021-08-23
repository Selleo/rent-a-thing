ActiveAdmin.register Customer do
  menu priority: 3

  # ==============
  # ==== LIST ====
  # ==============

  filter :full_name

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :full_name, :email, :phone


  form do |f|
    inputs 'Basic info', class: 'two-column' do
      input :full_name
    end

    inputs 'Contact info', class: 'two-column' do
      input :email
      input :phone
    end

    actions
  end
end
