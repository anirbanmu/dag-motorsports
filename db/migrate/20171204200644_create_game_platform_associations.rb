class CreateGamePlatformAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :game_platform_associations do |t|
      t.references :game, index: true
      t.references :platform, index: true

      t.timestamps
    end
  end
end
