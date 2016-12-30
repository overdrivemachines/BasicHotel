class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :name
      t.string :access_code
      t.text :notes

      t.timestamps
    end
  end
end
