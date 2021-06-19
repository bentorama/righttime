Rails.application.routes.draw do
  devise_for :users 
  root to: 'pages#home'
  get "/price_update", to: 'events#price_update', as: :price_update

  resources :orders, only: [:show, :create] do
    resources :payments, only: :new
    resources :reviews, only: [ :new, :create ]
    collection do
      get :my_bookings
    end
    member do
      get 'directions'
    end
  end
  resources :events do
    resources :favourites, only: [:create]
  end
  resources :venues
  resources :favourites, only: [:index, :destroy]
  # resources :bookings do
  #   resources :reviews, only: [ :new, :create ] 
  # end

  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
