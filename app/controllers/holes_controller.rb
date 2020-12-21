class HolesController < ApplicationController
    before_action :require_login

    def round_entry
    @team=Team.find_by(id: params[:team_id])
    @n=0
    @i=0
    end

    def create
        byebug
        team=Team.find_by(id: params[:round][:team_id].to_i)
        if helpers.current_user.tournament_ids.include?(team.tournament_id)
        round=Round.create(round_params)
            if !round.blank?
                params[:hole].each do |hole|
                @hole=Hole.create(hole_params(hole))
                round.holes << @hole
                end
            end
        end
        redirect_to "/tournaments/#{team.tournament.id}/posting"
    end



    private
    def hole_params(my_params)
            my_params.permit(:score, :round_id)
    
    end

    def round_params
       params.require(:round).permit(:team_id)
    end

    def require_login
        return head(:forbidden) unless session.include? :user_id
      end
    

end
