class CreateFarmers < ActiveRecord::Migration
  def change
    create_table :farmers do |t|
      t.string :name
      t.string :slug, index: true

      t.timestamps null: false
    end
  end
end
