class CreateEmotionQuestions < ActiveRecord::Migration[7.2]
  def change
    create_table :emotion_questions do |t|
      t.references :emotion, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
