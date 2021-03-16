require 'sidekiq-scheduler'

class UpdateChatsCountWorker
  include Sidekiq::Worker

  def perform(*args)
    sql = "UPDATE applications SET chats_count = (SELECT COUNT(application_id) FROM chats WHERE application_id = #{application_id} )"
    result = ActiveRecord::Base.connection.execute(sql)
  end
end
