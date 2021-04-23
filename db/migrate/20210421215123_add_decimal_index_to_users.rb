class AddDecimalIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :decimal_index, :integer, null: false
  end
end
