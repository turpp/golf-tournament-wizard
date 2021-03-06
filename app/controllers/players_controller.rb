class PlayersController < ApplicationController
    before_action :require_login
    
    def index        
        if params[:touranment_id]
            @tournament=Tournament.find_by(id: params[:tournament_id])
            @players=@tournament.players
        else
        @players=helpers.current_user.players 
        end
    end

    def number
    end

    def times
        @n=params[:number].to_i
        if @n > 0
            redirect_to "/players/new/#{@n}"
        else
            redirect_to "/players/number", alert: "Number field can't be blank and must be 1 or more."
        end
    end

    def new
        @n=params[:number].to_i
        @player=Player.new
    end

    def create
        @n=params[:number].to_i
        if create_players(params[:player])
        else
        redirect_to players_path
        end
    end
    
    def show
        if authorized(params[:id])

            @player=find_player
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    def edit
        if authorized(params[:id])
            @player=find_player
            @player_edit=Player.new
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    def update
        @player=find_player
        if @player.update(player_params(params[:player]))
            redirect_to player_path(@player)
        else
            render :edit
        end
    end

    def destroy
        find_player.destroy
        redirect_to players_path
    end


    private
    def player_params(my_params)
        my_params.permit(:name, :user_id, :handicap)
    end

    def require_login
        return head(:forbidden) unless session.include? :user_id
    end

    def create_players(params)
        params.each do |player|
            @player=Player.create(player_params(player))
            if !@player.valid?
                return render :new
            end
        end
        redirect_to players_path
    end

    def authorized(params)
        helpers.current_user.player_ids.include?(params.to_i)
    end

    def find_player
        Player.find_by(id: params[:id])
    end

end
