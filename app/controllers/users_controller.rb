class UsersController < ApplicationController
    
    def new
        @user=User.new
        3.times{@user.players.build}
    end

    def create
        user=User.create(user_params)
        session[:user_id] = user.id
        redirect_to user_path(user)
    end

    def edit
    end

    def update
    end

    def show
        @user=User.find_by(id: params[:id])
        @tournaments=@user.tournaments
        @players=@user.players
    end

    private

    def user_params
        params.require(:user).permit(:username, :password, :password_confirmation, :name, :address, :phone_number)
    end
end
