class AddLineUidToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :line_uid, :string
    add_index :users, :line_uid, unique: true
  end
end
