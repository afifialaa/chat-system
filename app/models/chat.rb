class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages

    validates :num, presence: true, uniqueness: true
    validates :application_id, presence: true

    def self.count_messages_count(chat_id)
        UpdateMessagesCountWorker.perform_async('updateMessages', chat_id)
        UpdateMessagesCountWorker.perform_in('updateMessages', chat_id)
    end
end
