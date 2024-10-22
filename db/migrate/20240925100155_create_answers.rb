class CreateAnswers < ActiveRecord::Migration[7.2]
  def change
    create_table :answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :emotion_question, null: false, foreign_key: true
      t.text :answer

      t.timestamps
    end
  end
end
