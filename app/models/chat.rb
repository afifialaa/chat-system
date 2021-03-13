class Chat < ApplicationRecord
    belongs_to :application
    has_many :messages

    validates :num, presence: true, uniqueness: true
    validates :application_id, presence: true
end
