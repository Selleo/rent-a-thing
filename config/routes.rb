Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :bookings, only: [:index, :show, :destroy]
  get 'confirm_booking/:id' => 'bookings#update', as: :confirm_booking

  namespace :v1 do
    get "statistics/booked_days_by_month" => "bookings_api#index"
    get 'booked_days_by_month' => 'booked_days_by_month#show', as: :booked_days_by_month
    get 'bookings_by_item' => 'bookings_by_item#show', as: :bookings_by_item
    get 'new_users_per_month' => 'new_users_per_month#show', as: :new_users_per_month
    get 'users_per_month' => 'users_per_month#show', as: :users_per_month
    get 'income_per_month' => 'income_per_month#show', as: :income_per_month
  end
end
