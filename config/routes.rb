Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:index, :show, :destroy]

  namespace :v1 do
    get 'available_items' => 'available_items#index'
    get 'booked_days_by_month' => 'booked_days_by_month#show', as: :booked_days_by_month
<<<<<<< HEAD
    get 'items_by_booking_number' => 'items_by_booking_number#show', as: :items_by_booking_number
    get 'created_customers_by_month' => 'created_customers_by_month#show', as: :created_customers_by_month
    resources :bookings, only: [:create]
=======
    get 'bookings_by_item' => 'bookings_by_item#show', as: :bookings_by_item
    get 'new_customers_by_month' => 'new_customers_by_month#show', as: :new_customers_by_month
    post 'bookings/:id/confirm' => 'confirmations#create'
    resources :bookings, only: :create
>>>>>>> aadcb3c766d512b0f3d592c80c5381c25a08f4eb
  end
end
