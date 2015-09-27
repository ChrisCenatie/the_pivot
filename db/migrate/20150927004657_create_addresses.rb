class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :street_address
      t.string :apt
      t.string :city
      t.string :state
      t.integer :zip_code

      t.timestamps null: false
    end
  end
end
