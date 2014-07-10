module ConversationsHelper
  def can_view_conversation?(conversation, user)
    !conversation.group.private? || (user && conversation.group.member?(user))
  end
end
