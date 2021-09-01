Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: :index

  namespace :v1 do
    get 'available_items' => 'available_items#index'
    get 'booked_days_by_month' => 'booked_days_by_month#show', as: :booked_days_by_month
    get 'bookings_by_item' => 'bookings_by_item#index', as: :bookings_by_item
    get 'new_customers_by_month' => 'new_customers_by_month#index', as: :new_customers_by_month
    get 'all_customers_by_month' => 'all_customers_by_month#index', as: :all_customers_by_month
    get 'confirm_booking/:id' => 'confirm_booking#index'
    post 'bookings' => "bookings#create"
  end
end
