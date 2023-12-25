class AddHobbiesToGiftSuggestions < ActiveRecord::Migration[7.0]
  def change
    add_column :gift_suggestions, :hobbies, :string, array: true, default: []
  end
end
