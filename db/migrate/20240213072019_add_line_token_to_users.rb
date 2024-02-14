class AddLineTokenToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :line_token, :string
  end
end
