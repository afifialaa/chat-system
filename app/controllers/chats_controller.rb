class ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token

    # Create new chat
    def create
        @user = current_user
        @application = Application.find_by(token: params[:token], user_id: @user::id)
        @chat = Chat.new(application_id: @application::id, num: 0)
        sql = "SELECT MAX(num) FROM chats WHERE application_id = #{@application::id}"
        res = ActiveRecord::Base.connection.execute(sql).as_json
        @chat::num = res[0][0] + 1
        if @chat.save
            render(json: {message: @chat.num}, status: :created)
        else
            render(json: {error: @chat.errors}, status: :unprocessable_entity)
        end
    end

    # Delete chat
    def delete
        @user = current_user
        @application = Application.find_by(token: params[:token], user_id: @user::id)
        @chat = Chat.find_by(num: params[:num], application_id: @application::id)
        if @chat.destroy
            render(json: { message: "Chat was deleted successfully" }, stauts: :ok)
        else
            render(json: { error: @chat.errors }, stauts: :not_modified)
        end
    end

    # Returns chat
    def show
        @user = current_user
        @application = Application.find_by(token: params[:token], user_id: @user::id)
        @chat = Chat.find_by(application_id: @application::id, num: params[:num])
        @messages = Message.select('body').where(chat_id: @chat::id).as_json(:except => :id)
        render(json: { messages: @messages }, status: :ok)
    end

    # User joins chat
    def join
        @user = current_user
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
        @user = current_user
        @application = Application.find_by(token: params[:token], user_id: @user::id)
        @chat = Chat.find_by(num: params[:num], application_id: @application_id)
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
