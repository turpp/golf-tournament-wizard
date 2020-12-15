class Tournament < ApplicationRecord
    has_many :teams
    has_many :players, through: :teams
    belongs_to :user
    has_many :holes, through: :teams
end
