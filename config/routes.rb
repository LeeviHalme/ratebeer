Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :beers
  
  resources :users do
    post 'toggle_disabled', on: :member
  end
  
  resources :breweries do
    post 'toggle_activity', on: :member
  end

  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only: [:index, :show]
  resources :beer_styles, path: "styles", only: [:index, :show, :edit, :update, :destroy]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resource :session, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  post 'places', to: 'places#search'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'

  # Defines the root path route ("/")
  root 'breweries#index'
end
