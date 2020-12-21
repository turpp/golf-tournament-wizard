class SessionsController < ApplicationController
    def home
    end

    def new
    end

    # def create
    #     @user = User.find_by(username: params[:username])
    #     return head(:forbidden) unless @user.authenticate(params[:password])
    #     session[:user_id] = @user.id
    #     redirect_to user_path(@user)
    # end

    def create
        if params[:username]
        @user = User.find_by(username: params[:username])
        return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
        else
        @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
            u.password = auth['uid']
            
        end
        session[:user_id] = @user.id
            redirect_to user_path(@user)
        end

    end
    
    def destroy
        session.delete :user_id
        redirect_to root_path
    end 

    private
    def auth
        request.env['omniauth.auth']
      end
end
