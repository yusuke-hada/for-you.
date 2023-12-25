class CreateGiftSuggestions < ActiveRecord::Migration[7.0]
  def change
    create_table :gift_suggestions do |t|
      t.integer :age, null: false
      t.integer :gender, null: false
      t.string :business, null: false, limit: 20
      t.string :hobby, null: false, limit: 20
      t.string :interest, null: false, limit: 20
      t.string :purpose, null: false, limit: 20
      t.string :relationship, null: false, limit: 20
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
