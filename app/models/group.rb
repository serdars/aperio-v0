class Group < ActiveRecord::Base
  belongs_to :organization

  has_many :memberships
  has_many :users, through: :memberships

  def member?(user)
    return false unless user

    memberships.any? {|m| m.user.id == user.id}
  end
end
