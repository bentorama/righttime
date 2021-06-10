Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  
  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
    resources :reviews, only: [ :new, :create ]
    collection do
      get :my_bookings
    end
  end
  resources :events 
  resources :venues
  # resources :bookings do
  #   resources :reviews, only: [ :new, :create ] 
  # end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
