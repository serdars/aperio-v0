module ConversationsHelper
  def has_notification?(conversation, user)
    Notification.where(user: user, notifiable: conversation).count > 0
  end
end
