class Guest < ApplicationRecord
  belongs_to :user
  belongs_to :party_session
end
