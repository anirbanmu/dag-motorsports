class CreateCircuits < ActiveRecord::Migration[5.1]
  def change
    create_table :circuits do |t|
      t.string :name
      t.float :length # stored in meters
      t.references :track, foreign_key: true, index: true

      t.timestamps
    end
  end
end
