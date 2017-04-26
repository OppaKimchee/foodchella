Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "posts#index"
  get "posts/random", to: "posts#random", as: :random
  resources :users
  resources :posts do
    resources :votes, shallow: true, only: [:create]
  end
  resources :sessions, only: [:new, :create, :destroy]
  # Create a better looking URL for logging in
  get "/login", to: "sessions#new"
  get "/logout", to: "sessions#destroy"

end
