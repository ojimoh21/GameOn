class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :party_session

  has_one :vote, dependent: :destroy
  has_many :team_members, dependent: :destroy
  has_many :teams, through: :team_members
end
