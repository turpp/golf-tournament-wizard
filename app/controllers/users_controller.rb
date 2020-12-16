class UsersController < ApplicationController
    
    def new
    end

    def create
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


end
