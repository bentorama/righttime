class AddEventToFavourites < ActiveRecord::Migration[6.0]
  def change
    add_reference :favourites, :event, null: false, foreign_key: true
  end
end

