class CreatePlatforms < ActiveRecord::Migration[5.1]
  def change
    create_table :platforms do |t|
      t.string :name, index: { unique: true }

      t.timestamps
    end
  end
end
