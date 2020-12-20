class Round < ApplicationRecord
  belongs_to :team
  has_many :holes
end
