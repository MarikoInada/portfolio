class Emotion < ApplicationRecord
    has_many :emotion_questions
    has_many :diary_entries
end
