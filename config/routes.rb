Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:index, :show, :destroy]

  namespace :v1 do 
    get "iveable_items" => "avaiable_items"
    get "/statistic/booked_days_by_month" => "booked_days_by_month"
end
