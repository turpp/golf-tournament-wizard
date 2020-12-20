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
         @player=Player.new
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
    def edit
        @player=Player.find_by(id: params[:id])

    end
    def update
        @player=Player.find_by(id: params[:id])
        @player.update(player_params(params[:player]))
        if params[:tournament_id]
            redirect_to "/players/signups/tournaments/#{params[:tournament_id].to_i}"
        else
            redirect_to player_path(@player)
        end
    end

    def signups
        @tournament=Tournament.find_by(id: params[:tournament_id])
        @n=0
        @g=0
        @players=@tournament.players
        @team=Team.new
    end


    def signed_in
        @player=Player.find_by(id: params[:id])
        @player.update(player_params(params[:player]))
        #put in a flash that says update

        redirect_to "/players/signups/tournaments/#{params[:tournament_id].to_i}"

    end

    private
    def player_params(my_params)
        # params.require(:player).permit(:name, :handicap, :paid, :mulligan, :user_id)
        my_params.permit(:name, :user_id, :handicap, :mulligan, :paid)
    end

end
