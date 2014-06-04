module OrganizationsHelper
  def membership(group, user)
    Membership.where(group: group, user: user).first
  end

  def filter_conversations(conversations, group: nil)
    conversations.select do |conversation|
      if group
        conversation.group == group
      else
        true
      end
    end
  end
end
