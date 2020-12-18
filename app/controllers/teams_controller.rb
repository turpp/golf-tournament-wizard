class TeamsController < ApplicationController
    def index
    end
    
    def number
        byebug
    end

    def show
    end

    def new
        @n=params[:number].to_i
        @team=Team.new
        @team.players.build
        @tournament=Tournament.find_by(id: params[:tournament_id])
        @players_on_team=@tournament.players_on_team
    end

    def edit
        @team=Team.find_by(id: params[:id])
    end

    def create
        byebug
        params[:team].each do |t|
        team=Team.create(team_params(t))
        t[:player_ids].each do |p|
            byebug
        player=Player.find_by(id: p[:id][:id].to_i)
        team.players << player
        end
    end

        
    end

    def update
        byebug
    end

    def tournament
        @tournament=Tournament.find_by(id: params[:id])
        @teams=@tournament.teams
        @n=0
        @i=0
    end

    def number
    
    end

    def times
        byebug
        tournament_id=params[:tournament_id]
        n=params[:number].to_i
        redirect_to "/teams/new/#{n}/#{tournament_id}"
    end

    private

    def team_params(my_params)
        my_params.permit(:final_score, :tournament_id, :divison)
    end



end
