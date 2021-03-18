class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one :profile_image, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  attachment :profile_image

  enum is_deleted: {Invalid: true, Available: false}

    def active_for_authentication?
        super && (self.is_deleted === "Invalid")
    end
  # 会員の退会(論理削除)
end
