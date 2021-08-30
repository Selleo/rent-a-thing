Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

     resources :bookings, only: [:show, :index, :destroy]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: :index

  namespace :v1 do
    get 'available_items' => 'available_items#index'
    get 'booked_days_by_month' => 'booked_days_by_month#show', as: :booked_days_by_month
  end
end
