class UsersController < ApplicationController
    def new
        @user=User.new
    end
    def create
        @user=User.new(user_params)
        if @user.valid?
            user=User.create(user_params)
            session[:user_id] = user.id
            redirect_to user_path(user)
        else
            render :new
        end
    end

    def edit
    end

    def update
    end

    def show
        @user=User.find_by(id: params[:id])
        if helpers.current_user == @user
            @tournaments=@user.tournaments
            @players=@user.players
        else
            redirect_to root_path, alert: "You can't do that!"
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :name, :address, :phone_number)
    end
end
