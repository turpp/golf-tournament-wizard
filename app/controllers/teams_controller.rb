class TeamsController < ApplicationController
    def show
    end

    def new
        @team=Team.new
        @team.players.build
    end

    def edit
        @team=Team.find_by(id: params[:id])
    end

    def create
        byebug
    end

    def update
        byebug
    end

    def tournament
        @tournament=Tournament.find_by(id: params[:id])
        @teams=@tournament.teams
        @n=0
        @i=0
    end

end
