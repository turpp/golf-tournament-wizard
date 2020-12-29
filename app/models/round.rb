class Round < ApplicationRecord
  belongs_to :team
  has_many :holes


  def round_total
    hole_scores=[]
    self.holes.each do |hole|
      hole_scores << hole.score
    end
    self.score=hole_scores.inject(0){|sum,x| sum + x }
    self.save
    self.score
  end

end
