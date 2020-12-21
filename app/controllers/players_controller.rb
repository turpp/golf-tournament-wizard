class PlayersController < ApplicationController
    before_action :require_login
    
    def index        
        @players=helpers.current_user.players 
    end
def number
end

def times
    @n=params[:number].to_i
    redirect_to "/players/new/#{@n}"
end
    def new
         @n=params[:number].to_i
         @player=Player.new
    end

    def create
        params[:player].each do |player|
            Player.create(player_params(player))
        end
        redirect_to players_path
    end
    
    def show
        if helpers.current_user.player_ids.include?(params[:id].to_i)
        @player=Player.find_by(id: params[:id])
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end
    def edit
        if helpers.current_user.player_ids.include?(params[:id].to_i)
        @player=Player.find_by(id: params[:id])
        else
            redirect_to root_path, alert: "You can't do that!"
        end

    end
    def update
        @player=Player.find_by(id: params[:id])
        @player.update(player_params(params[:player]))
            redirect_to player_path(@player)
    end


    private
    def player_params(my_params)
        # params.require(:player).permit(:name, :handicap, :paid, :mulligan, :user_id)
        my_params.permit(:name, :user_id, :handicap)
    end

    def require_login
        return head(:forbidden) unless session.include? :user_id
      end

end
