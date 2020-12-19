class TournamentsController < ApplicationController
    def index
        #need to add make @tournaments pull only the current user touraments with the seession
        @tournaments=Tournament.all
    end

    def new
        @tournament=Tournament.new
        @players=Player.all
    end

    def create

        t=Tournament.create(tournament_params)
        redirect_to tournament_path(t)
    end

    def edit
        @tournament=Tournament.find_by(id: params[:id])
        @players=Player.all
        @teams=@tournament.teams
        @n=0
        @g=0
    end

    def update
        @tournament=Tournament.find_by(id: params[:id])
        @tournament.teams.each do |t|
            PlayersTeam.where(team_id: t.id).each do |pt|
                pt.delete
            end
            t.delete
        end
    
        @tournament.update(tournament_params)
        # params[:tournament][:player_ids].each do |id|
        #     player=Player.find_by(id: id )
        #     @tournament.players << player
        # end
        # @tournament.players_teams.each do |pt|
        #     pt.update(players_teams_params)
        # end
        redirect_to tournament_path(@tournament)
    end

    def show
        @tournament=Tournament.find_by(id: params[:id])
        @players=@tournament.players
        @n=0
    end

    def destroy
        tournament=Tournament.find_by(id: params[:id])
        tournament.teams.each do |t|
            t.players_teams.each do |pt|
                pt.delete
            end
            t.delete
        end
        tournament.delete
        redirect_to tournaments_path
    end
    def start
        @tournament=Tournament.find_by(id: params[:id])
        @n=0
        @players=@tournament.players
    end

    private
    def tournament_params
        params.require(:tournament).permit(:name, :date, :entry_fee, :user_id, :players_on_team, teams_attributes: [players_teams_attributes: [:player_id]])
    end

    def players_teams_params
        params.require(:tournament).permit(players_teams_attributes: [:player_id])
    end
end

