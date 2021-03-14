class User < ApplicationRecord
    has_secure_password

    has_many :applications, dependent: :destroy

    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
end
