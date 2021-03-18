class Post < ApplicationRecord

  belongs_to :user

  enum is_recruitment:[:加入案件, :募集案件]
  enum is_online:[:可能, :不可]
  enum period:[:期間の定めなし, :一ヶ月以内, :三ヶ月以内, :六ヶ月以内]
  enum guarantee:[:なし, :あり]

  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one_attached :video

  def create_notification_by(current_user)
        notification = current_user.active_notifications.new(
          post_id: id,
          visited_id: user_id,
          action: "favorite"
        )
        notification.save if notification.valid?
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search)
      if search
        Post.where(['title LIKE ?', "%#{search}%"])
      else
        Post.all
      end
  end

end
