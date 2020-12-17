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
        byebug
        # t=Tournament.create(tournament_params)
        # redirect_to tournament_path(t)
    end

    def edit
        @tournament=Tournament.find_by(id: params[:id])
        @players=Player.all
    end

    def update
        byebug
    end

    def show
        @tournament=Tournament.find_by(id: params[:id])
        @players=@tournament.players
    end

    private
    def tournament_params
        params.require(:tournament).permit(:name, :date, :entry_fee, :user_id, :team_tournament, :players)
    end
end

