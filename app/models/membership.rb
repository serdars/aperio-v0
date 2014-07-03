class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  after_create :capture_action

  protected
    def capture_action
      Action.new({
        user: user,
        action_type: Action::Type::JOIN_GROUP,
        actionable: group
      }).save!
    end
end
