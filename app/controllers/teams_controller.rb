class TeamsController < ApplicationController
    
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
        params[:team].each do |t|
            byebug
        @team=Team.create(team_params(t))
        t[:player_ids].each do |p|
        player=Player.find_by(id: p[:id][:id].to_i)
        @team.players << player
        end
        end
    redirect_to tournament_path(@team.tournament_id)
    end

        

    def update
        byebug
        # if params[:signups]=='true'
        #     team=Team.find_by(id: params[:id])
        #     team.update(team_params(params[:team]))
        #     redirect_to "/teams/signup/#{team.tournament_id}"
        # else
        # team=Team.find_by(id: params[:id])
        # PlayersTeam.where(team_id: team.id).each do |pt|
        #     pt.delete
        # end
        # team.update(team_params(params[:team]))
    
        # redirect_to tournament_path(team.tournament_id)
        # end
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
        tournament_id=params[:tournament_id]
        n=params[:number].to_i
        redirect_to "/teams/new/#{n}/#{tournament_id}"
    end
    def destroy


        team=Team.find_by(id: params[:id])
        i=team.tournament_id
        team.players_teams.each do |pt|
            pt.delete
        end
        team.delete
        redirect_to tournament_path(i)
        
    end

    # ======================================
    def signup
        @tournament=Tournament.find_by(id: params[:tournament_id])
        @teams=@tournament.teams
        @g=0
        @n=0
        
    end

    
    private

    def team_params(my_params)
        my_params.permit(:final_score, :tournament_id, :paid, :mulligan, :divison, players_teams_attributes: [:player_id])
    end



end
