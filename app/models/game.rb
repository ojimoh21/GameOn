class Game < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :party_games, dependent: :destroy
end
