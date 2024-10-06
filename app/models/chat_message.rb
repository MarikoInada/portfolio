class ChatMessage < ApplicationRecord
  belongs_to :user

  validates :content, presence: true
  validates :sender, inclusion: { in: ['user', 'bot'] }
end
