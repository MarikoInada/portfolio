class CreateEmotions < ActiveRecord::Migration[7.2]
  def change
    create_table :emotions do |t|
      t.string :name
      t.string :color_code

      t.timestamps
    end
  end
end
