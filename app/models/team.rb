class Team < ApplicationRecord
  belongs_to :tournament
  has_many :players_teams
  has_many :players, through: :players_teams
  has_many :holes
  accepts_nested_attributes_for :players
  accepts_nested_attributes_for :players_teams
end
