class Tournament < ApplicationRecord
    has_many :teams
    has_many :players, through: :teams
    belongs_to :user
    has_many :holes, through: :teams
    accepts_nested_attributes_for :players
end
