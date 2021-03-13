class UsersController < ApplicationController
    # skip CRSF token authentication
    skip_before_action :verify_authenticity_token

    def create
        @user = User.new(user_params)
        if @user.save
            render(json: { message: "User created successfully" }, status: :created)
        else
            render(json: {error: @user.errors}, status: :unprocessable_entity)
        end
    end

    def delete
        @user = User.find_by(email: params[:id])
        if @user.destroy
            render(json: { message: "User was deleted successfully"}, status: :ok)
        else
            render(json: { error: @user.errors}, status: :not_modified)
        end
    end

    private
    def user_params
        params.permit(:email, :password)
    end
end
