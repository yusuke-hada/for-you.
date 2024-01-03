class CreateMemos < ActiveRecord::Migration[7.0]
  def change
    create_table :memos do |t|
      t.string :name, null: false, limit: 252
      t.string :goods, null: false, limit: 252
      t.date :time
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
