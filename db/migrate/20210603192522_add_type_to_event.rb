class AddTypeToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :category, :string
  end
end
