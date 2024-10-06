class DiaryEntry < ApplicationRecord
  belongs_to :user
  belongs_to :emotion
end
