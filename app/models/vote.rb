class Vote < ApplicationRecord
  belongs_to :guest
  belongs_to :party_game
end
