ActiveAdmin.register Item do
  menu priority: 2

  # ==============
  # ==== LIST ====
  # ==============

  scope :active, default: true
  scope :archived

  filter :name
  filter :description

  # ==============
  # ==== EDIT ====
  # ==============

  permit_params :name, :description, :archived
end
