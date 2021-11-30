class PartySession < ApplicationRecord
  belongs_to :user
  has_many :guests, dependent: :delete_all
  has_many :party_games, dependent: :delete_all
  has_one :chatroom
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  validates :title, :description, :start_date, :address, presence: true
end
