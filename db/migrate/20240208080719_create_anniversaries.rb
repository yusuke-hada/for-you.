class CreateAnniversaries < ActiveRecord::Migration[7.0]
  def change
    create_table :anniversaries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false, limit: 252
      t.date :date, null: false
      t.text :description, null: false, limit: 252

      t.timestamps
    end
  end
end
