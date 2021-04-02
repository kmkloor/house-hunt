class AddNotesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.text :note, null: false
      t.datetime :created_at, default: :now
      t.string :author
      t.references :property, foreign_key: true
    end
 
  end
end
