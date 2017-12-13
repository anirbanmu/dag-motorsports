class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :filename
      t.text :base64
      t.string :mimetype
      t.references :imageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
