class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :interest
      t.text :strength
      t.text :hobby

      t.timestamps
    end
  end
end
