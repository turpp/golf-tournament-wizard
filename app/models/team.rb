class Team < ApplicationRecord
  belongs_to :tournament
  has_many :players_teams
  has_many :players, through: :players_teams
  has_many :holes
end
