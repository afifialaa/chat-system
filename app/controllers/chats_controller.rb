class ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token

    # Create new chat
    def create
        @application = Application.find_by(token: params[:token])
        @chat = Chat.new(num: params[:num], application_id: @application::id)
        if @chat.save
            Application.update_chats_count(@application::id)
            render(json: { num: @chat::num}, status: :created)
        else
            render(json: {error: @chat.errors}, status: :unprocessable_entity)
        end
    end

    # Delete chat
    def delete
        @application = Application.find_by(token: params[:token])
        @chat = Chat.find_by(num: params[:num], application_id: @application::id)
        if @chat.destroy
            Application.update_chats_count(@application::id)
            render(json: { message: "Chat was deleted successfully" }, stauts: :ok)
        else
            render(json: { error: @chat.errors }, stauts: :not_modified)
        end
    end

    # Returns chat
    def show
        @application = Application.find_by(token: params[:token])
        @chat = Chat.find_by(application_id: @application::id, num: params[:num])
        @messages = Message.select('body').where(chat_id: @chat::id).as_json(:except => :id)
        render(json: { messages: @messages }, status: :ok)
    end

    # User joins chat
    def join
        @user = User.find_by(email: session[:user_email])
        @application = Application.select("id").where(token: params[:token])
        @chat = Chat.find_by(application_id: @application::id, num: params[:num])

        @userchat = Userschat.new(user_id: @user::id, chat_id: @chat::id)
        if @userchat.save
            render(json: {message: "User joined chat"}, status: :ok)
        else
            render(json: {message: "Failed to join chat"}, status: :not_modified)
        end
    end

    # User exits chat
    def exit
        @user = User.find_by(email: session[:user_email])
        @chat = Chat.find_by(num: params[:num])
        @userchat = Userschat.find_by(user_id: @user::id, chat_id: @chat::id)
        if @userchat.destroy
            render(json: {message: "User exited chat"}, status: :ok)
        else
            render(json: {error: @userchat.errors}, status: :ok)
        end

    end

    private
    def chat_params
        params.permit(:num)
    end

    # Generate chat number
end
