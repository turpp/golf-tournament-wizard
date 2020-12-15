class Round < ApplicationRecord
  belongs_to :tournament
  belongs_to :player
  has_many :holes
end
