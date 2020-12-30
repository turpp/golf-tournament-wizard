class Tournament < ApplicationRecord
    has_many :teams
    has_many :players, through: :teams
    belongs_to :user
    # has_many :holes, through: :teams
    has_many :players_teams, through: :teams
    accepts_nested_attributes_for :teams
    accepts_nested_attributes_for :players_teams
    has_many :rounds, through: :teams
    validates :name, :date, :players_on_team, :number_of_rounds, :holes_per_round, presence: true

    def pretty_date
        self.date.strftime("%A, %b %d")
    end
    
    
end
