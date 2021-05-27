Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/create'
  get 'bookings/index'
  get 'bookings/show'
  get 'bookings/edit'
  get 'bookings/update'
  get 'bookings/new'
  get 'bookings/create'
  get 'bookings/destroy'
  get 'bookings/index'
  devise_for :users
  root to: 'pages#home'

  resources :events
  resources :venues
  resources :bookings do
    resources :reviews, only: [ :new, :create ] 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
