class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, class_name: "User", foreign_key: "subject_id"
  belongs_to :notifiable, polymorphic: true

  def message
    case action
    when "join_group"
      "has joined"
    else
      "has done something"
    end
  end
end
