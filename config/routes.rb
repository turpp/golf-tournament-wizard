Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/teams/times/:tournament_id', to: 'teams#times'
  get '/teams/signup/:tournament_id', to: "teams#signup"
  get '/players_teams/checkin/:tournament_id', to: "players_teams#checkin"
  get "/players/number", to: 'players#number'
  get '/teams/number/:tournament_id', to: 'teams#number'
  post '/teams/number', to: 'teams#times' 
  get '/holes/round_entry/teams/:team_id', to: 'holes#round_entry'
  get '/teams/round/:team_id', to: "teams#round"
  resources :tournaments
  resources :users
  resources :players
  resources :teams
  resources :players_teams
  resources :holes
  root "sessions#home"
  get "/players/new/:number", to: "players#new"
  post "/players/number", to: 'players#times'

  get '/teams/tournament/:id', to: 'teams#tournament'
  get '/teams/new/:number/:tournament_id', to: 'teams#new'
end
