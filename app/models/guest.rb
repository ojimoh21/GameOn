class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :party_session

  has_one :vote
end
