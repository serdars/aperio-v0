class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :organization
  belongs_to :action
  belongs_to :conversation
end
