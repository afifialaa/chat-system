class SessionsController < ApplicationController

    # skip CRSF token authentication
    skip_before_action :verify_authenticity_token

    before_action :authorized, only: [:show]

    # log user in
    def login
        @user = User.find_by(email:params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user::id
            render(json: { message: "User logged in successfully"}, status: :ok)
        else
            render(json: { message: "Wrong email or password"}, status: :unauthorized)
        end
    end

    # log user out
    def destroy
        session[:user_email] = nil 
        render(json: {message: "user logged out"}, status: :ok)
    end

    # fetch current user
    def show
        render(json: {user: self.current_user, loggedin: self.logged_in?}, status: :ok)
    end
end
