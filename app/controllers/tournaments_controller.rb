class TournamentsController < ApplicationController
    def index
    end

    def new
    end

    def create
    end

    def edit
    end

    def update
    end

    def show
        @tournament=Tournament.find_by(id: params[:id])
        @players=@tournament.players
    end
end
