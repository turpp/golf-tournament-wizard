class HolesController < ApplicationController
    def round_entry
    @team=Team.find_by(id: params[:team_id])
    @n=0
    @i=0
    end

    def new

    end

    def create
        team=Team.find_by(id: params[:hole].first[:team_id].to_i)
        params[:hole].each do |hole|
            @hole=Hole.create(hole_params(hole))
        end
        redirect_to "/tournaments/#{team.tournament.id}/posting"
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
