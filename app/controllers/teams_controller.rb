class TeamsController < ApplicationController
    before_action :require_login

    def number
    end


    def new
        if helpers.current_user.tournament_ids.include?(params[:tournament_id].to_i)
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
        if helpers.current_user.tournament_ids.include?(@team.tournament_id)
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
                @team=Team.create(team_params(params[:team]))
                params[:team][:player_ids].each do |p|
                    player=Player.find_by(id: p[:id][:id].to_i)
                    @team.players << player
                    end
                
                    redirect_to "/players_teams/checkin/#{@team.tournament_id}"
                    
            else
                redirect_to "/players_teams/checkin/#{@team.tournament_id}"
            end
        else
           

            params[:team].each do |t|
                @team=Team.new(team_params(t))
                t[:player_ids].each do |p|
                    if player=Player.find_by(id: p[:id][:id].to_i)
                    @team.players << player
                    else
                       return redirect_to "/teams/new/#{params[:team].count}/#{@team.tournament_id}", alert: "Must select Golfer from the drop down." 
                    end
                end
                @team.save
            end
            redirect_to tournament_path(@team.tournament_id)
        end
    end

        

    def update
        team=Team.find_by(id: params[:id])
        PlayersTeam.where(team_id: team.id).each do |pt|
            pt.delete
        end
        team.update(team_params(params[:team]))
    
        redirect_to tournament_path(team.tournament_id)
    end


    def number
    
    end

    def times
        if !params[:number].blank?
        tournament_id=params[:tournament_id]
        n=params[:number].to_i
        redirect_to "/teams/new/#{n}/#{tournament_id}"
        else
            redirect_to "/teams/number/#{params[:tournament_id]}", alert: "You must enter a number."
        end
    end
    def destroy
        team=Team.find_by(id: params[:id])
        if helpers.current_user.tournament_ids.include?(team.tournament_id)
        i=team.tournament_id
        team.players_teams.each do |pt|
            pt.delete
        end

        team.rounds.each do |round|
            round.holes.each do |hole|
                hole.delete
            end
            round.delete
        end
        team.delete
        redirect_to tournament_path(i)
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


end
