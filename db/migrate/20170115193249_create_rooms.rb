class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :room_number, null: false
      t.string :location
      t.boolean :vacant, null: false, default: true
      t.boolean :clean, null: false, default: true
      t.boolean :inventory, null: false, default: true
      t.references :room_type, foreign_key: true

      t.timestamps
    end
  end
end
