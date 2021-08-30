Rails.application.routes.draw do
  namespace :v1 do
    get 'available_items' => 'available_items#index'
    namespace :statistics do
      get 'booked_days_by_month' => 'booking_api#booked_days_by_month'
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: :index
  
  namespace :v1 do
    get 'available_items' => 'available_items#index'
    get 'booked_days_by_month' => 'booked_days_by_month#show', as: :booked_days_by_month
  end
end
