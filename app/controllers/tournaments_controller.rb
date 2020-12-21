class TournamentsController < ApplicationController
    before_action :require_login
    skip_before_action :require_login, only: [:results]


    def index
        @tournaments=helpers.current_user.tournaments
    end

    def new
        @tournament=Tournament.new
    end

    def create

        t=Tournament.create(tournament_params)
        redirect_to tournament_path(t)
    end

    def edit
        @tournament=Tournament.find_by(id: params[:id])
        if helpers.current_user.tournament_ids.include?(@tournament.id)
        @players=Player.all
        @teams=@tournament.teams
        @n=0
        @g=0
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    
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
        if helpers.current_user.tournament_ids.include?(tournament.id)
        tournament.teams.each do |t|
            t.players_teams.each do |pt|
                pt.delete
            end
            t.delete
        end
        tournament.delete
        redirect_to tournaments_path
    else
        redirect_to root_path, alert: "You can't do that!"
    end

    end

    def posting
        @tournament=Tournament.find_by(id: params[:touranment_id])
        if helpers.current_user.tournament_ids.include?(@tournament.id)
        @players=@tournament.players
        @n=0
        @h=0
        @r=0
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    
            
    end

    def results
        @tournament=Tournament.find_by(id: params[:tournament_id])
        @t=0
        @h=0
        @r=0
        hsh={}
        @tournament.teams.each do |team|
            hsh[team] = team.final_score
        end
        @teams=hsh.sort_by {|team, final_score| final_score}
    end

    private
    def tournament_params
        params.require(:tournament).permit(:name, :date, :entry_fee, :number_of_rounds, :holes_per_round, :user_id, :players_on_team, teams_attributes: [players_teams_attributes: [:player_id]])
    end

    def players_teams_params
        params.require(:tournament).permit(players_teams_attributes: [:player_id])
    end
    def require_login
        return head(:forbidden) unless session.include? :user_id
      end

end

