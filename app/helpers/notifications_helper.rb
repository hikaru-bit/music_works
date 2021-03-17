module NotificationsHelper

  def notification_form(notification)
      @visiter = notification.visiter
      your_post = link_to 'あなたの投稿', post_path(notification), style:"font-weight: bold;"
      notification.action
          tag.a(notification.visiter.name, href:users_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
