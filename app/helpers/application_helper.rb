module ApplicationHelper
  def can_start_conversation?(group, user)
    group && user && group.member?(user)
  end

  def can_manage_organization?(organization, user)
    organization.admin?(user)
  end

  def can_view_group?(group, user)
    if user.nil?
      !group.private
    else
      group.member?(user) || !group.private
    end
  end

  def can_view_conversation?(conversation, user)
    can_view_group?(conversation.group, user)
  end
end
