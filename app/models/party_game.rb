class PartyGame < ApplicationRecord
  belongs_to :game
  belongs_to :party_session

  has_many :votes, dependent: :delete_all
  has_many :teams, dependent: :destroy
  has_many :team_members, through: :teams
  has_many :guests, through: :votes
end
