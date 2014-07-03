class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :conversation

  after_create :capture_action

  protected
    def capture_action
      Action.new({
        user: user,
        action_type: Action::Type::POST_MESSAGE,
        actionable: conversation,
        data: { message_id: self.id }.to_json
      }).save!
    end
end
