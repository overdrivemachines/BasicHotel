class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.integer :room_number
      t.string :location
      t.boolean :vacant
      t.boolean :clean
      t.boolean :inventory
      t.references :RoomType, foreign_key: true

      t.timestamps
    end
  end
end
