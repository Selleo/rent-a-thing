Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: %i[index show destroy]

  namespace :v1 do
    resources :booking_confirmation, only: :show, as: :booking_confirmation
    get 'available_items' => 'available_items#index'
    get 'booked_days_by_month' => 'booking_api#booked_days_by_month', as: :booked_days_by_month
    get 'bookings_by_items' => 'booking_api#bookings_by_item', as: :bookings_by_item
    get 'new_customers_by_month' => 'booking_api#new_customers_by_month', as: :new_customers_by_month
    post 'bookings/:id/confirm' => 'confirmations#create'
    post 'bookings' => 'bookings_creation#create'
  end
end
