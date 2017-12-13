class CreateTracks < ActiveRecord::Migration[5.1]
  def change
    create_table :tracks do |t|
      t.string :name
      t.references :game, foreign_key: true, index: true

      t.timestamps
    end
  end
end
