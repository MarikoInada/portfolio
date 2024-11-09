class CreateHobbies < ActiveRecord::Migration[7.2]
  def change
    create_table :hobbies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
