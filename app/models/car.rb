class Car < ApplicationRecord
  default_scope { order(name: :asc) }
  belongs_to :game
  validates :name, presence: true, uniqueness: { scope: :game, case_sensitive: false }
end
