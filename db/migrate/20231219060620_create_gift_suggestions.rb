class CreateGiftSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :gift_suggestions do |t|

      t.timestamps
    end
  end
end
