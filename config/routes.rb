Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/teams/times/:tournament_id', to: 'teams#times'
  get '/teams/signup/:tournament_id', to: "teams#signup"
  get '/players_teams/signups/:tournament_id', to: "players_teams#signups"
  get "/players/number", to: 'players#number'
  get '/teams/number/:tournament_id', to: 'teams#number'
  post '/teams/number', to: 'teams#times' 
  resources :tournaments
  resources :users
  resources :players
  resources :teams
  resources :players_teams
  root "sessions#home"
  get "/players/new/:number", to: "players#new"
  post "/players/number", to: 'players#times'

  get '/teams/tournament/:id', to: 'teams#tournament'
  get '/teams/new/:number/:tournament_id', to: 'teams#new'
end
