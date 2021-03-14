class ApplicationController < ActionController::Base
    helper_method :logged_in?, :current_user

    def current_user
        if session[:user_email]
            @user = User.find_by(email: session[:user_email])
        end
    end

    def logged_in?
        !!current_user
    end

    def authorized
        render(json: { message: "User is not logged in"}, status: :ok) unless logged_in?
    end
end
