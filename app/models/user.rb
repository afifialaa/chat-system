class User < ApplicationRecord
    has_many :books, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
end
