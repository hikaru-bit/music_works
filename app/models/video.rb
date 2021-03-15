class Video < ApplicationRecord

  has_one_attached :video

  belongs_to :user
  belongs_to :post

end
