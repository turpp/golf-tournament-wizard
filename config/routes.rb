Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/players/number", to: 'players#number'

  resources :tournaments
  resources :users
  resources :players

  root "sessions#home"

  get "/players/new/:number", to: "players#new"
  get "/players/number", to: 'players#number'
  post "/players/number", to: 'players#times'
end
