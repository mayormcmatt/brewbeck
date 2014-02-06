Beer::Application.routes.draw do

    get "/beers/search", to: "beers#search"
    post "/beers/search", to: "beers#search"

    resources :users, :beers
    resources :sessions, only: [:new, :create, :destroy]

    root to: "beers#index"

    match '/signup', to: 'users#new', via: 'get'

    match '/signout', to: 'sessions#destroy', via: 'destroy'

    match '/signin', to: 'sessions#new', via: 'get'

end
