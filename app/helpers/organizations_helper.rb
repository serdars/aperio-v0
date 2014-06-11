module OrganizationsHelper
  def membership(group, user)
    Membership.where(group: group, user: user).first
  end

  def filter_conversations(conversations, group: nil, user: nil)
    conversations.select { |c|
      if group && c.group != group
        false
      else
        true
      end
    }.select { |c|
      if user && !c.group.member?(user)
        false
      else
        true
      end
    }.select {|c|
      if c.group.private
        if user && c.group.member?(user)
          true
        else
          false
        end
      else
        true
      end
    }
  end
end
