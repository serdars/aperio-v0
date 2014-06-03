class Conversation < ActiveRecord::Base
  belongs_to :group
  belongs_to :user

  has_many :messages
end
