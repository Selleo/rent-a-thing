Rails.application.routes.draw do

  namespace :v1 do
    resources :available_items  #get 'available_items'
    resources :api
    namespace :statistics do
      resources :booked_days_by_month
    end
  end
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :bookings, only: [:index, :show, :destroy]

 
  
end
