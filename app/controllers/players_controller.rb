class PlayersController < ApplicationController
    def index
        #need to make @players just for the current user
        
        @players=Player.all 
    end
def number
end

def times
    @n=params[:number].to_i
    redirect_to "/players/new/#{@n}"
end
    def new
         @n=params[:number].to_i
    end

    def create
        params[:player].each do |player|
            Player.create(player_params(player))
        end
        redirect_to players_path
    end
    
    def show
        @player=Player.find_by(id: params[:id])
    end


    private
    def player_params(my_params)
        # params.require(:player).permit(:name, :handicap, :paid, :mulligan, :user_id)
        my_params.permit(:name, :user_id, :handicap)
    end

end
