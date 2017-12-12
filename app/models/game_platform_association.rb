class GamePlatformAssociation < ApplicationRecord
  belongs_to :game
  belongs_to :platform
  validates :platform_id, uniqueness: { scope: :game_id } # Should be unique in the combination of game & platform.
end
