class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :conversations
  has_many :messages
  has_many :notifications

  acts_as_authentic do |c|
    c.validate_login_field = false

    # http://stackoverflow.com/questions/23031902/rails-4-1-0-and-authlogic-bcrypt-issue
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def organizations
    groups.map{|g| g.organization}.uniq
  end

  def conversation_notification_count_by_org
    collection = { }

    organizations.each do |org|
      collection[org] = conversation_notifications(org).count
    end

    collection
  end

  def conversation_notifications(org = nil)
    if org
        Notification.where(user: self, organization: org, notifiable_type: "Conversation")
    else
      Notification.where(user: self, notifiable_type: "Conversation")
    end
  end

  def group_conversation_notifications(group)
    notifications = [ ]
    conversation_notifications(group.organization).each do |notification|
      notifications << notification if notification.notifiable.group == group
    end
    notifications
  end

  def memberships_by_org
    collection = { }

    memberships.each do |membership|
      collection[membership.group.organization] ||= [ ]
      collection[membership.group.organization] << membership
    end

    collection
  end

  def conversations_by_org
    collection = { }

    conversations.each do |conv|
      collection[conv.group.organization] ||= [ ]
      collection[conv.group.organization] << conv
    end

    collection
  end
end
