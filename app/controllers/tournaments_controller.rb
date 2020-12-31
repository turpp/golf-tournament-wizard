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
        @tournament=Tournament.new(tournament_params)
        if @tournament.valid?
            @tournament.save
            redirect_to tournament_path(@tournament)
        else
            render :new
        end
    end

    def edit
        @tournament=Tournament.find_by(id: params[:id])
        if user_authorized(@tournament.id)
            @players=helpers.current_user.players
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    def update
        @players=helpers.current_user.players
        @tournament=Tournament.find_by(id: params[:id])
        if Tournament.new(tournament_params).valid?
            @tournament.teams.each do |t|
                delete_rounds_holes(t)
                PlayersTeam.where(team_id: t.id).each do |pt|
                    pt.delete
                end
                t.delete
            end
            @tournament.update(tournament_params)
            redirect_to tournament_path(@tournament)
        else
            @tournament.update(tournament_params)
            render :edit
        end
    end

    def show
        if user_authorized(params[:id].to_i)
            @tournament=Tournament.find_by(id: params[:id])
            @players=@tournament.players
            @n=0
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    def destroy
        tournament=Tournament.find_by(id: params[:id])
        if user_authorized(tournament.id)
            delete_teams(tournament)
            tournament.delete
            redirect_to tournaments_path
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    def posting
        @tournament=Tournament.find_by(id: params[:touranment_id])
        if user_authorized(@tournament.id)
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
        @teams=teams_sorted_by_score(@tournament)
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

    def user_authorized(tournament_id)
        helpers.current_user.tournament_ids.include?(tournament_id)
    end

    def delete_rounds_holes(team)
        team.rounds.each do |round|
            round.holes.each do |hole|
                hole.delete
            end
            round.delete
        end
    end

    def delete_teams(tournament)
        tournament.teams.each do |t|
            t.players_teams.each do |pt|
                pt.delete
            end
            t.delete
        end
    end

    def teams_sorted_by_score(tournament)
        hsh={}
        tournament.teams.each do |team|
            hsh[team] = team.final_score
        end
        hsh.sort_by {|team, final_score| final_score}
    end

end

