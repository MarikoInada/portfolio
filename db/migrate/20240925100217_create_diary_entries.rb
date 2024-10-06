class CreateDiaryEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :diary_entries do |t|
      t.references :user, null: false, foreign_key: true
      t.references :emotion, null: false, foreign_key: true
      t.date :entry_date
      t.text :content

      t.timestamps
    end
  end
end
