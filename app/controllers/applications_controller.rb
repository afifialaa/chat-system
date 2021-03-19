class ApplicationsController < ApplicationController

    # skip CRSF token authentication
    skip_before_action :verify_authenticity_token
    

    # Create new application
    def create
        @user = current_user
        token = generate_application_token
        @application = Application.new(token: token, name: params[:name], user_id: @user::id)
        if @application.save
            session[:user_id] = @user::id
            render(json: { token: @application::token }, status: :created)
        else
            render(json: {errors: @application.errors}, status: :unprocessable_entity)
        end
    end

    # Delete application
    def delete
        @user = current_user
        @application = Application.find_by(token: params[:token], user_id:@user::id)
        if @application.destroy
            render(json: { message: "Application was deleted successfully" }, status: :ok)
        else
            render(json: { error: @application.errors }, status: :not_modified)
        end
    end

    # Rename application
    def update
        @user = current_user
        @application = Application.find_by(token: params[:token], user_id:@user::id)
        @application.name = params[:name]
        if @application.save
            render(json: { message: "Application was renamed successfully" }, status: :ok)
        else
            render(json: { error: @application.errors}, status: :not_modified)
        end
    end

    # Find application -> returns chats in application
    def show
        @application = Application.find_by(token: params[:token])
        @chats = Chat.select("num").where(application_id: @application::id).as_json(:except => :id)
        render(json: {chats: @chats}, status: :ok)
    end

    private
    def generate_application_token
        SecureRandom.hex(10)
    end

    def chatapp_params
        params.permit(:token, :name)
    end
end
