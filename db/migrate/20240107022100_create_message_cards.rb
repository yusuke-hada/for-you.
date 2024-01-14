class CreateMessageCards < ActiveRecord::Migration[7.0]
  def change
    create_table :message_cards do |t|
      t.string :recipient_name, null: false, limit: 252
      t.text :message, null: false, limit: 252
      t.string :background_image, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
