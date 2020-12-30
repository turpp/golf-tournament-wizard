class PlayersTeam < ApplicationRecord
  belongs_to :player
  belongs_to :team
  accepts_nested_attributes_for :team

  scope :team_records, ->(team_id) { where("team_id = ?", team_id)}
end
