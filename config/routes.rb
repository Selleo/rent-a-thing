Rails.application.routes.draw do

  namespace :v1 do
    resources :items_available  #get 'available_items'
    namespace :statistics do
      resources :booked_days_by_month
    end
  end
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bookings, only: [:index, :show, :destroy]
  resources :api

 
  
end
