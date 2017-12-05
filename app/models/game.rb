class Game < ApplicationRecord
  has_many :game_platform_associations
  has_many :platforms, through: :game_platform_associations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :release, presence: true
  validates :developer, presence: true
  validates :publisher, presence: true
end
