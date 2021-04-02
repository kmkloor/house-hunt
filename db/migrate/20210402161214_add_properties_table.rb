class AddPropertiesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :properties do |t|
      t.integer :mls_id
      t.datetime :created_at, default: :now
      t.text :address
      t.text :city
      t.integer :zip
      t.string :img_url
      t.float :price
      t.integer :square_feet
      t.float :lot_size
      t.integer :year_built
    end
  end
end
