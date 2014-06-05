class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  after_create :notify_users

  protected
    def notify_users
      group.users.each do |group_user|
        if group_user != user
          Notification.new({
            user: group_user,
            subject: user,
            action: "join_group",
            notifiable: group
          }).save!
        end
      end
    end
end
