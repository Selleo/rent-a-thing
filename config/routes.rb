Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:index, :show, :destroy]

  namespace :v1 do
    get "statistics/booked_days_by_month" => "bookings_api#index"
    get 'booked_days_by_month' => 'booked_days_by_month#show', as: :booked_days_by_month
    get 'bookings_by_item' => 'bookings_by_item#show', as: :bookings_by_item
    get 'new_users_per_month' => 'new_users_per_month#show', as: :new_users_per_month
  end
end
