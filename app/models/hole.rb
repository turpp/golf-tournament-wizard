class Hole < ApplicationRecord
    belongs_to :round
    validates :score, presence: true

end
