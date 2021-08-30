Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:index, :show, :destroy]

  namespace :v1 do
    get 'available_items' => 'available_items#index'
    get 'booked_days_by_month' => 'booked_days_by_month#show'
    get 'bookings_by_month' => 'bookings_by_month#index'
  end
end