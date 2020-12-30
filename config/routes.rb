Rails.application.routes.draw do
  # resources :rounds
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  #nested= /tournaments/:tournament_id/teams/times
  # post '/teams/times/:tournament_id', to: 'teams#times' 
  #-------------------------

  #nested /tournament/:tournament_id/players_teams/checkin
  # get '/players_teams/checkin/:tournament_id', to: "players_teams#checkin"
  #-------------------------------------------------
  get "/players/number", to: 'players#number'

  #nested /tournament/:tournament_id/teams/number
  # get '/teams/number/:tournament_id', to: 'teams#number'


  # post '/teams/number', to: 'teams#times' 


  #-----------------
  #nested= /teams/:team_id/holes/round_entry
  # get '/holes/round_entry/teams/:team_id', to: 'holes#round_entry'
  #-------------------

  get '/tournaments/:touranment_id/posting', to: "tournaments#posting"
  get '/tournaments/:tournament_id/results', to: "tournaments#results"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/auth/facebook/callback' => 'sessions#create' 

  resources :tournaments do
    get '/teams/new/:number', to: 'teams#new'
    get '/teams/number', to: 'teams#number'
    get '/players_teams/checkin', to: "players_teams#checkin"
    post '/teams/number', to: 'teams#times'
  end
  
  resources :users
  resources :players
  resources :teams, except: :index  do #hole round entry
    get '/holes/round_entry', to: 'holes#round_entry'
    resources :holes, only: :create
  end
  resources :players_teams, only: :update
  # resources :holes, only: :create
  root "sessions#home"


  get "/players/new/:number", to: "players#new"
  post "/players/number", to: 'players#times'

#nested= /tournament/:touranment_id/teams/new/:number
  # get '/teams/new/:number/:tournament_id', to: 'teams#new'
end
