class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.string :phone
      t.string :fax
      t.string :email
      t.references :addressable, polymorphic: true

      t.timestamps
    end
  end
end
