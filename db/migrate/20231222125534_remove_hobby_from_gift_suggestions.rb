class RemoveHobbyFromGiftSuggestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :gift_suggestions, :hobby, :string
  end
end
