class EmotionQuestion < ApplicationRecord
  belongs_to :emotion
  has_many :answers
end
