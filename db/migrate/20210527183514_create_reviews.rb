class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.text :event_review
      t.integer :venue_rating
      t.references :booking, null: false, foreign_key: true

      t.timestamps
    end
  end
end
