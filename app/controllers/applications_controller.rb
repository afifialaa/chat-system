class ApplicationsController < ApplicationController

    # skip CRSF token authentication
    skip_before_action :verify_authenticity_token

    # Create new application
    def create
        @user = User.find_by(email: "afifi@gmail.com")
        token = generate_application_token
        @application = Application.new(token: token, name: params[:name], user_id: @user::id)
        if @application.save
            render(json: { token: @application::token }, status: :created)
        else
            render(json: {errors: @application.errors}, status: :unprocessable_entity)
        end
    end

    # Delete application
    def delete
        @application = Application.find_by(token: params[:token])
        if @application.destroy
            render(json: { message: "Application was deleted successfully" }, status: :ok)
        else
            render(json: { error: @application.errors }, status: :not_modified)
        end
    end

    # Rename application
    def update
        @application = Application.find_by(token: params[:token])
        @application.name = params[:name]
        if @application.save
            render(json: { message: "Application was renamed successfully" }, status: :ok)
            # Return application token
        else
            render(json: { error: @application.errors}, status: :unprocessable_entity)
        end
    end

    private
    def generate_application_token
        SecureRandom.hex(10)
    end

    def chatapp_params
        params.permit(:token, :name)
    end
end
