class Tournament < ApplicationRecord
    has_many :rounds
    has_many :players, through: :rounds
    belongs_to :user
end
