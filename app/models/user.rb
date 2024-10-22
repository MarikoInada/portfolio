class User < ApplicationRecord
  authenticates_with_sorcery!
    has_secure_password
  
    has_many :diary_entries
    has_many :answers
    has_many :emotion_questions
    has_many :chat_messages, dependent: :destroy
    has_one :profile

    belongs_to :current_emotion, class_name: 'Emotion', optional: true
end
