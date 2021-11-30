class Chatroom < ApplicationRecord
  belongs_to :party_session
  has_many :messages
end
