class PlayersController < ApplicationController
    def index
        #need to make @players just for the current user
        
        @players=Player.all 
    end

    def new
        # @player=Player.new
        @user=User.new
        3.times{@user.players.build}
        @player=Player.new
        @empty_players=[]
         @n=0
        3.times{@empty_players << Player.new}
    #    @player=3.times {Player.new}
    end

    def create
        byebug
        # @n=params[:hidden]
        # c=1
        # @n.times{Player.new(parmas.require(:player).permit(:player#{}))}
        # player=Player.create(player_params)
        # redirect_to player_path(player)
    end
    
    def show
        @player=Player.find_by(id: params[:id])
    end


    private
    def player_params
        params.require(:player).permit(:name, :handicap, :paid, :mulligan, :user_id, new_player1: [:name, :handicap])
    end

end
