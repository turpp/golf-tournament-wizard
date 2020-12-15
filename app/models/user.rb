class User < ApplicationRecord
    has_many :tournaments
    has_many :players
end
