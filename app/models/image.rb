class Image < ApplicationRecord
  belongs_to :cocktail
  mount_uploader :image, PictureUploader
end
