class Game < ApplicationRecord
  default_scope { order(name: :asc) }
  has_many :game_platform_associations, dependent: :destroy
  has_many :platforms, through: :game_platform_associations
  has_many :tracks, dependent: :destroy
  has_one :image, as: :imageable, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :release, presence: true
  validates :developer, presence: true
  validates :publisher, presence: true
end
