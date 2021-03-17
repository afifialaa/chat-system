class MessagesController < ApplicationController
    # skip CRSF token authentication
    skip_before_action :verify_authenticity_token

    def create
        @application = Application.find_by(token: params[:token])
        @chat = Chat.find_by(application_id: @application::id, num: params[:chat_num])
        @user = User.find_by(email: session[:user_email])
        @message = Message.new(body: params[:body], num: params[:msg_num], chat_id: @chat::id, user_id: @user::id)

        if @message.save
            Chat.increment_counter(:messages_count, @chat::id)
            render(json: { num: @message::id}, status: :ok)
        else
            render(json: { error: @message.errors}, status: :unprocessable_entity)
        end
    end

    def search
        @application = Application.find_by(token: params[:token])
        @chat = Chat.find_by(num: params[:num], application_id: @application::id)
        @messages = Message.search_messages(params[:query], @chat::id)
        if @messages
            render(json: { chats: @messages}, status: :ok)
        else
            render(json: { error: @messages.errors}, status: :unprocessable_entity)
        end
    end

    def delete
        @application = Application.find_by(token: params[:token])
        @chat = Chat.find_by(num: params[:num], application_id: @application::id)
        @message = Message.find_by(num: params[:num], chat_id: @chat::id)
        if @message.destroy
            Chat.increment_counter(:messages_count, @chat::id)
            render(json: { message: "Message was deleted successfully"}, status: :ok)
        else
            render(json: { error: @message.errors}, status: :not_modified)
        end
    end

    private
    def message_params
        params.permit(:body, :num )
    end
end
