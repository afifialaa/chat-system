class UsersController < ApplicationController
    # skip CRSF token authentication
    skip_before_action :verify_authenticity_token

    before_action :authorized, only: [:delete, :show]

    # Create new user
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user::id
            render(json: { message: "User created successfully" }, status: :created)
        else
            render(json: {error: @user.errors}, status: :unprocessable_entity)
        end
    end

    # Delete user
    def delete
        @user = User.find(session[:user_id])
        if @user.destroy
            render(json: { message: "User was deleted successfully"}, status: :ok)
        else
            render(json: { error: @user.errors}, status: :not_modified)
        end
    end

    def show
        @user = User.find(session[:user_id])
        if @user
            render(json: {user: @user}, status: :ok)
        else
            render(json: {message: "Log in first"}, status: :ok)
        end
    end

    private
    def user_params
        params.permit(:email, :password)
    end
end
