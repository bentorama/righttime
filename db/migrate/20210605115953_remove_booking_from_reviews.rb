class RemoveBookingFromReviews < ActiveRecord::Migration[6.0]
  def change
    remove_reference :reviews, :booking, null: false, foreign_key: true
  end
end
