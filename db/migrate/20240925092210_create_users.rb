class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, index: { unique: true }
      t.string :crypted_password
      t.string :salt
      t.integer :current_emotion_id

      t.timestamps
    end
  end
end
