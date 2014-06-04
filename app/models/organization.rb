class Organization < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :tag_assignments, as: :taggable
  has_many :tags, through: :tag_assignments
  has_many :groups

  after_create :create_groups

  def default_group
    # For now we assume the first group is the default group we would like
    # users to join to.
    groups.first
  end

  def admin_group
    # For now we assume second group is the Admins group
    groups[1]
  end

  def member?(user)
    groups.any? do |group|
      group.member?(user)
    end
  end

  def admin?(user)
    # For now we assume second group is the Admins group
    admin_group.member?(user)
  end

  def conversations
    Conversation.where(group: groups)
  end

  protected
    def create_groups
      [
        {
          name: "All Organization",
          description: "Everyone in #{name}"
        },
        {
          name: "Admins",
          description: "Administrators of the organization.",
          visible: false,
          private: true
        },
        {
          name: "Members",
          description: "Members who have been active in the past."
        },
        {
          name: "Volunteers",
          description: "Folks who have volunteered here before.",
          private: true
        },
        {
          name: "Board",
          description: "Board Members.",
          private: true
        }
      ].each do |group_desc|
        group = Group.new(group_desc.merge({organization: self}))
        group.save!
      end
    end
end
