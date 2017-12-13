class Track < ApplicationRecord
  default_scope { order(name: :asc) }
  belongs_to :game
  has_many :circuits, dependent: :destroy
  validates :name, presence: true, uniqueness: { scope: :game, case_sensitive: false }
end
