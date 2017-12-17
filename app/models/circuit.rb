class Circuit < ApplicationRecord
  default_scope { order(name: :asc) }
  belongs_to :track
  validates :name, presence: true, uniqueness: { scope: :track, case_sensitive: false }
end
