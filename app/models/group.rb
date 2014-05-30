class Group < ActiveRecord::Base
  belongs_to :organization

  has_many :memberships
  has_many :users, through: :memberships

  def is_member?(user)
    return false unless user

    users.map { user.id }
      .include? user.id
  end
end
