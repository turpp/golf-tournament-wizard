class PlayersTeamsController < ApplicationController
    before_action :require_login

    
    def checkin
        if helpers.current_user.tournament_ids.include?(params[:tournament_id].to_i)
        @tournament=Tournament.find_by(id: params[:tournament_id])
        @teams=@tournament.teams
        @n=0
        @team=Team.new
        @all=[]
        @players=helpers.current_user.players
        else
            redirect_to root_path, alert: "You can't do that!"
        end

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

    def require_login
        return head(:forbidden) unless session.include? :user_id
      end

end
