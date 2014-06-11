class Conversation < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :messages

  after_destroy :clean_notifications

  def clean_notifications
    Notification.where(notifiable_type: "Conversation", notifiable_id: id).destroy_all
  end
end
