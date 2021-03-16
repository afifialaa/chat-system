require 'sidekiq-scheduler'

class UpdateChatsCountWorker
  include Sidekiq::Worker

  def perform(*args)
    # Do something
    Application.count_chats
  end
end
