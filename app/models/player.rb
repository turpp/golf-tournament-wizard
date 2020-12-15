class Player < ApplicationRecord
    belongs_to :user
    has_many :players_teams
    has_many :teams, through: :players_teams
    has_many :tournaments, through: :teams
    has_many :holes, through: :teams
end
