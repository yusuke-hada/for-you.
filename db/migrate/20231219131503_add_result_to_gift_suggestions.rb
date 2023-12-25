class AddResultToGiftSuggestions < ActiveRecord::Migration[7.0]
  def change
    add_column :gift_suggestions, :result, :string
  end
end
