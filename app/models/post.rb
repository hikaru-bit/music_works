class Post < ApplicationRecord

  belongs_to :user

  enum is_recruitment:[:加入案件, :募集案件]
  enum is_online:[:可能, :不可]
  enum period:[:期間の定めなし, :一ヶ月以内, :三ヶ月以内, :六ヶ月以内]
  enum guarantee:[:なし, :あり]

  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many  :tag_relationships, dependent: :destroy
  has_many  :tags, through: :tag_relationships
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

  def save_tags(savepost_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(name: new_name)
      self.tags << post_tag
    end
  end

end
