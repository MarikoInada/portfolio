class CreateChatMessages < ActiveRecord::Migration[7.2]
  def change
    create_table :chat_messages do |t|
      t.text :content
      t.string :sender
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
