class AddAttendeesToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :num_attendees, :integer
  end
end
