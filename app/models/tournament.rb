class Tournament < ApplicationRecord
    has_many :rounds
    has_many :players, through: :rounds
    belongs_to :user
    has_many :holes, through: :rounds
end
