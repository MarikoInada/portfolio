class Emotion < ApplicationRecord
    belongs_to :user
    has_many :emotion_questions
    has_many :diary_entries
end
