class User < ApplicationRecord
    has_many :tournaments
    has_many :players
    accepts_nested_attributes_for :players

    has_secure_password
    validates :name, :username, :password, presence: true
end
