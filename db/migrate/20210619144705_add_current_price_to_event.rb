class AddCurrentPriceToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :current_price, :decimal
  end
end
