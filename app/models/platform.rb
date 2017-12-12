class Platform < ApplicationRecord
  has_many :game_platform_associations, dependent: :destroy
  has_many :games, through: :game_platform_associations
  validates :name, presence: true
end
