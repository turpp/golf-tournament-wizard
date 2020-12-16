class UsersController < ApplicationController
    
    def new
        @user=User.new
        3.times{@user.players.build}
    end

    def create
        byebug
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
