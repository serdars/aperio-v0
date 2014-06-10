class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  after_create :notify_users

  protected
    def notify_users
      conversation.group.users.each do |group_user|
        if group_user != user
          Notification.new({
            user: group_user,
            organization: conversation.group.organization,
            subject: user,
            action: "post_message",
            notifiable: conversation
          }).save!
        end
      end
    end
end
