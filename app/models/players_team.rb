class PlayersTeam < ApplicationRecord
  belongs_to :player
  belongs_to :team
  accepts_nested_attributes_for :team
end
