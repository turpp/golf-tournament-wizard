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
        @n=params[:number].to_i
        params[:player].each do |player|
            @player=Player.create(player_params(player))
            if !@player.valid?
                return render :new
            end
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
        @player_edit=Player.new
        else
            redirect_to root_path, alert: "You can't do that!"
        end

    end
    def update
        @player=Player.find_by(id: params[:id])
        # @player_edit=Player.new(player_params(params[:player]))
        # if @player_edit.valid?
        if @player.update(player_params(params[:player]))

            redirect_to player_path(@player)
        else
           
            render :edit
        end
    end

    def destroy
            Player.find(params[:id]).destroy
            redirect_to players_path
         
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
