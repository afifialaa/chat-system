class Application < ApplicationRecord
    belongs_to :user

    validates :token, presence: true, uniqueness: true
    validates :name, presence: true
    validates :user_id, presence: true
end
