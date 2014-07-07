class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :conversations
  has_many :messages
  has_many :notifications
  has_many :actions

  acts_as_authentic do |c|
    c.validate_login_field = false

    # http://stackoverflow.com/questions/23031902/rails-4-1-0-and-authlogic-bcrypt-issue
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def organizations
    groups.map{|g| g.organization}.uniq
  end

  def has_notification?(conversation: conversation)
    !Notification.where(user:self, conversation: conversation).empty?
  end

  def conversation_notifications(group: group = nil)
    if group.nil?
      Notification.where(user:self).where("notifications.conversation_id IS NOT NULL")
    else
      Notification.where(user:self, group: group).where("notifications.conversation_id IS NOT NULL")
    end
  end

  def notification_count(type: type = nil, organization: organization = nil, group: group = nil)
    notifications = Notification.where(user:self)

    # Check if group of organization is specified
    if group
      notifications = notifications.where(group: group)
    elsif organization
      notifications = notifications.where(organization: organization)
    end

    # type can be :group or :conversation
    if type
      case type
      when :group
        notifications = notifications.where("notifications.conversation_id IS NOT NULL")
      when :conversation
        notifications = notifications.where("notifications.conversation_id IS NOT NULL")
      else
        puts "Unknown notification type: #{type}"
      end
    end

    # to calculate the count we group notifications by conversation in order to
    # filter out similar notifications
    count = 0
    notifications.group_by{|n| n.conversation}.each do |conversation, notifications|
      if conversation.nil?
        count += notifications.count
      else
        count += 1
      end
    end

    count
  end

end
