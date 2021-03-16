class UpdateMessagesCountWorker
  include Sidekiq::Worker

  def perform(chat_id)
    sql = "UPDATE chats SET messages_count = (SELECT COUNT(chat_id) FROM messages WHERE chat_id = #{chat_id} )"
    result = ActiveRecord::Base.connection.execute(sql)
  end
end
