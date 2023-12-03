class AddColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :role, :integer, default: 0, null: false
    add_column :users, :age, :integer, null: false
    add_column :users, :gender, :integer, null: false
    add_column :users, :business, :string
    add_column :users, :hobby, :string
  end
end
