class User < ApplicationRecord
  authenticates_with_sorcery!
  attr_accessor :password, :password_confirmation

  has_many :authentications, :dependent => :destroy
  accepts_nested_attributes_for :authentications
  has_many :diary_entries
  has_many :answers
  has_many :emotion_questions
  has_many :chat_messages, dependent: :destroy
  has_many :emotions, dependent: :destroy
  has_one :profile
  has_many :hobbies, dependent: :destroy

  belongs_to :current_emotion, class_name: 'Emotion', optional: true
  mount_uploader :image, ImageUploader
end
