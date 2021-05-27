Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :events
  resources :venues
  resources :bookings do
    resources :reviews, only: [ :new, :create ] 
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
