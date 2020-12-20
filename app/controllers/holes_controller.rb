class HolesController < ApplicationController
    def round_entry
    @team=Team.find_by(id: params[:team_id])
    @n=0
    @i=0
    end

    def new

    end

    def create
        byebug
        params[:hole].each do |hole|
            byebug
            # @hole=Hole.create(player_params(hole))
        end
        # redirect_to "/teams/round/#{@hole.team_id}"
    end

    def edit

    end

    def update

    end

    private
    def hole_params(my_params)
            my_params.permit(:score, :team_id)
    
    end
end
