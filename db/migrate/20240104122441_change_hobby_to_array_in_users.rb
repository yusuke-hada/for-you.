class ChangeHobbyToArrayInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :hobby, :string, array: true, default: [], using: "(string_to_array(hobby, ','))"
  end
end
