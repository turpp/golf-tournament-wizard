class Player < ApplicationRecord
    belongs_to :user
    has_many :rounds
    has_many :tournaments, through: :rounds
    has_many :holes, through: :rounds
end
