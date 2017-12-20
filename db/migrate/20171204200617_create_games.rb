class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name, index: { unique: true }
      t.date :release
      t.string :developer
      t.string :publisher

      t.timestamps
    end
  end
end
