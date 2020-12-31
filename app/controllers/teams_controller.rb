class TeamsController < ApplicationController
    before_action :require_login

    def number
    end

    def new
        if user_authorized(params[:tournament_id].to_i)
            @n=params[:number].to_i
            @tournament=Tournament.find_by(id: params[:tournament_id])
            @players_on_team=@tournament.players_on_team
            @players=helpers.current_user.players
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    def edit
        @team=Team.find_by(id: params[:id])
        if user_authorized(@team.tournament_id)
            @players=helpers.current_user.players
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    def create
        if params[:checkin]=="true"
            @team=Team.new(team_params(params[:team]))
            ids=params[:team][:player_ids].collect do |id|
                id[:id][:id]
            end
            if !ids.include?("")
                create_team
            else
                redirect_to "/tournaments/#{@team.tournament_id}/players_teams/checkin"
            end
        else
            params[:team].first[:player_ids].each do |id|
                if id[:id][:id]==""
                    return redirect_to "/tournaments/#{params[:tournament_id]}/teams/new/#{params[:team].count}", alert: "Must select Golfer from the drop down."
                end
            end 


            create_multiple_teams
            redirect_to tournament_path(@team.tournament_id)
        end
    end

    def update
        team=Team.find_by(id: params[:id])
        PlayersTeam.team_records(team.id).each do |pt|
            pt.delete
        end
        team.update(team_params(params[:team]))
        redirect_to tournament_path(team.tournament_id)
    end

    def number
    end

    def times
        if params[:number].to_i > 0
            redirect_to "/tournaments/#{params[:tournament_id]}/teams/new/#{params[:number]}"
        else
            redirect_to "/tournaments/#{params[:tournament_id]}/teams/number", alert: "You must enter a number greater than 0."
        end
    end

    def destroy
        team=Team.find_by(id: params[:id])
        if user_authorized(team.tournament_id)
            delete_players_teams(team)
            delete_rounds_holes(team)
            team.delete
            redirect_to tournament_path(team.tournament_id)
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    private
    def team_params(my_params)
        my_params.permit(:final_score, :tournament_id, :paid, :mulligan, :divison, players_teams_attributes: [:player_id])
    end

    def require_login
        return head(:forbidden) unless session.include? :user_id
    end

    def user_authorized(tournament_id)
        helpers.current_user.tournament_ids.include?(tournament_id)
    end

    def delete_players_teams(team)
        team.players_teams.each do |pt|
            pt.delete
        end
    end

    def delete_rounds_holes(team)
        team.rounds.each do |round|
            round.holes.each do |hole|
                hole.delete
            end
            round.delete
        end
    end

    def create_team
        @team=Team.create(team_params(params[:team]))
        params[:team][:player_ids].each do |p|
            player=Player.find_by(id: p[:id][:id].to_i)
            @team.players << player
        end
        redirect_to "/tournaments/#{@team.tournament.id}/players_teams/checkin"
    end

    def create_multiple_teams
        params[:team].each do |t|
            @team=Team.new(team_params(t))
            t[:player_ids].each do |p|
                if player=Player.find_by(id: p[:id][:id].to_i)
                    @team.players << player
                    @team.save
                end
            end
        end
    end
    
end
