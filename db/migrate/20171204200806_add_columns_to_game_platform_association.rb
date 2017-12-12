class AddColumnsToGamePlatformAssociation < ActiveRecord::Migration[5.1]
  def change
    add_column :game_platform_associations, :game_id, :integer
    add_column :game_platform_associations, :platform_id, :integer
  end
end
