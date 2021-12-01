class Team < ApplicationRecord
  belongs_to :party_game
  has_many :team_members, dependent: :destroy
end
