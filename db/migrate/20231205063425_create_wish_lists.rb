class CreateWishLists < ActiveRecord::Migration[7.0]
  def change
    create_table :wish_lists do |t|
      t.references :user, null: false, foreign_key: true
      t.string :item_name
      t.string :description

      t.timestamps
    end
  end
end
