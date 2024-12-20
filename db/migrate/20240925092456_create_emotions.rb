class CreateEmotions < ActiveRecord::Migration[7.2]
  def change
    create_table :emotions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :color_code

      t.timestamps
    end
  end
end
