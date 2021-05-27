class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.decimal :starting_price
      t.datetime :start_time
      t.text :description
      t.string :name
      t.integer :num_tickets
      t.integer :duration
      t.decimal :min_price
      t.references :venue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
