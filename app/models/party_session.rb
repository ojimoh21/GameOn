class PartySession < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  validates :title, :description, :start_date, :start_time, :location, presence: true
end
