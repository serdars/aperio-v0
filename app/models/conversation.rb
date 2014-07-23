class Conversation < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :messages

  after_destroy :clean_notifications
  after_destroy :clean_actions
  after_create :capture_action

  def clean_notifications
    Notification.where(conversation: self).destroy_all
  end

  def clean_actions
    Action.where(actionable: self).destroy_all
  end

  protected
    def capture_action
      Action.new({
        user: user,
        action_type: Action::Type::START_CONVERSATION,
        actionable: self
      }).save!
    end

end
