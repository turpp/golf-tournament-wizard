class Team < ApplicationRecord
  belongs_to :tournament
  has_many :players_teams
  has_many :players, through: :players_teams
  has_many :rounds

  has_many :holes, through: :rounds
  
  accepts_nested_attributes_for :players
  accepts_nested_attributes_for :players_teams


  def total_score
    total=[]
    self.rounds.each do |round|
      total << round.score
    end
    self.final_score=total.inject(0){|sum,x| sum + x }
    self.save
    self.final_score
  end
end
