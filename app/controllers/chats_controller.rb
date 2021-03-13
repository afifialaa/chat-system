class ChatsController < ApplicationController

    skip_before_action :verify_authenticity_token

    def create
        @application = Application.find_by(token: params[:token])
        @chat = Chat.new(num: params[:num], application_id: @application::id)
        if @chat.save
            results = ActiveRecord::Base.connection.execute("update applications set chats_count = (select count (*) from chats where chats.application_id = application.id)")
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
            render(json: { message: "Chat was deleted successfully" }, stauts: :ok)
        else
            render(json: { error: @chat.errors }, stauts: :not_modified)
        end
    end

    # Returns chat
    def show
        @application = Application.find_by(token: params[:token])
        @chat = Chat.where(num: params[:num], application_id: @application::id)
        render(json: { chat: @chat }, status: :ok)
    end

    private
    def chat_params
        params.permit(:num)
    end

    # Generate chat number
end
