Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:index, :show, :destroy]

  namespace :v1 do
    resources :bookings, only: [:create]
    get 'available_items' => 'available_items#index'
    get 'booked_days_by_month' => 'booked_days_by_month#show', as: :booked_days_by_month
    get 'booked_bikes' => 'booked_bikes#show', as: :booked_bikes
    get 'new_users'=>'new_users#show', as: :new_users
    get 'earnings'=>'earnings#show', as: :earnings
    get 'bookings_by_item' => 'bookings_by_item#show', as: :bookings_by_item
    get 'new_customers_by_month' => 'new_customers_by_month#show', as: :new_customers_by_month
    post 'bookings/:id/confirm' => 'confirmations#create'
    resources :bookings, only: :create
  end
end
