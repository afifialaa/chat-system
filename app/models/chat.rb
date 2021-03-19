class Chat < ApplicationRecord
    belongs_to :application, :counter_cache => :chats_count

    has_many :messages, dependent: :destroy
    validates :application_id, presence: true

    # before_save :increment_num

    def increment_num
        sql = "SELECT MAX(num) FROM chats WHERE application_id = #{@application::id}"
        res = ActiveRecord::Base.connection.execute(sql).as_json
        self.num = res[0] + 1
    end

end
