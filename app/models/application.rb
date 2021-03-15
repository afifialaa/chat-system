class Application < ApplicationRecord
    belongs_to :user

    validates :token, presence: true, uniqueness: true
    validates :name, presence: true
    validates :user_id, presence: true

    def self.count_chats(application_id)
        sql = "SELECT COUNT(application_id) FROM chats WHERE application_id = #{application_id} "
        result = ActiveRecord::Base.connection.execute(sql)
    end
end
