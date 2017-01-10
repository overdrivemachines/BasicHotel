class CreateRoomTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :room_types do |t|
      t.string :name
      t.string :code, limit: 4
      t.string :description
      t.references :property, foreign_key: true

      t.timestamps
    end
  end
end
