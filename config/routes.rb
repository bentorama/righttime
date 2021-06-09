Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
    resources :reviews, only: [ :new, :create ]
  end
  resources :events do
    resources :favourites, only: [:new, :create]
  end
  resources :venues
  resources :favourites, only: [:index, :delete]
  # resources :bookings do
  #   resources :reviews, only: [ :new, :create ] 
  # end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
