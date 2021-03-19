class Application < ApplicationRecord

    belongs_to :user
    has_many :chats

    validates :token, presence: true, uniqueness: true
    validates :name, presence: true
    validates :user_id, presence: true

    def self.update_chats_count(application_id)
        UpdateChatsCountWorker.perform_async('updateChats', application_id)
        UpdateChatsCountWorker.perform_in(20.seconds, 'updateChats', application_id)
    end

end
