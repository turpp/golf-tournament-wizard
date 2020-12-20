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

    def posting
        @tournament=Tournament.find_by(id: params[:touranment_id])
        @players=@tournament.players
        @n=0
        @h=0
        @r=0
    end

    private
    def tournament_params
        params.require(:tournament).permit(:name, :date, :entry_fee, :number_of_rounds, :holes_per_round, :user_id, :players_on_team, teams_attributes: [players_teams_attributes: [:player_id]])
    end

    def players_teams_params
        params.require(:tournament).permit(players_teams_attributes: [:player_id])
    end
end

