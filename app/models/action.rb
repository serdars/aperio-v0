class Action < ActiveRecord::Base
  belongs_to :user
  belongs_to :actionable, polymorphic: true

  after_create :notify_users

  module Type
    JOIN_GROUP = 0
    POST_MESSAGE = 1
    START_CONVERSATION = 2
  end

  protected
    # Notifies the users based on action
    def notify_users
      case action_type
      when Type::JOIN_GROUP
        if actionable.is_a? Group
          actionable.users.each do |notification_user|
            if notification_user != user
              Notification.new({
                user: notification_user,
                group: actionable,
                organization: actionable.organization,
                conversation: nil,
                action: self
              }).save!
            end
          end
        end
      when Type::POST_MESSAGE
        if actionable.is_a? Conversation
          # For the first message we will post a START_CONVERSATION notification
          unless actionable.messages.count == 1
            actionable.group.users.each do |notification_user|
              if notification_user != user
                Notification.new({
                  user: notification_user,
                  group: actionable.group,
                  organization: actionable.group.organization,
                  conversation: actionable,
                  action: self
                }).save!
              end
            end
          end
        end
      when Type::START_CONVERSATION
        if actionable.is_a? Conversation
          # For the first message we will post a START_CONVERSATION notification
          actionable.group.users.each do |notification_user|
            if notification_user != user
              Notification.new({
                user: notification_user,
                group: actionable.group,
                organization: actionable.group.organization,
                conversation: actionable,
                action: self
              }).save!
            end
          end
        end
      else
        puts "Unknown action type: #{action_type} for notifications."
      end
    end

end
