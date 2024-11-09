class Hobby < ApplicationRecord
    belongs_to :user
    mount_uploader :image, HobbyImageUploader
    validate :name_or_image_present

    private

    def name_or_image_present
        if name.blank? && image.blank?
          errors.add(:base, "趣味の名前または画像のいずれかを入力してください")
        end
    end    
end