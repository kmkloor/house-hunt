class CreateStatusTable < ActiveRecord::Migration[5.2]
  def change
    create_table :statuses do |t|
      t.string :status, null: false
      t.string :color
    end
    add_reference :properties, :status, foreign_key: true
  end
end
