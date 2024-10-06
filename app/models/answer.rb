class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :emotion_question
end
