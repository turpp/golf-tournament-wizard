class PlayersTeamsController < ApplicationController
    def checkin
        @tournament=Tournament.find_by(id: params[:tournament_id])
        @teams=@tournament.teams
        @n=0
        @team=Team.new
        @all=[]
    end

    def update
        pt=PlayersTeam.find_by(id: params[:id])
        pt.update(players_team_params)
        tournament=pt.team.tournament.id
        redirect_to "/players_teams/checkin/#{tournament}"
    end



    private
    def players_team_params
        params.require(:players_team).permit(:paid, :mulligan)
    end
end
