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

  def is_member?(user)
    groups.any? do |group|
      group.is_member?(user)
    end
  end

  protected
    def create_groups
      [
        {
          name: "All Organization",
          description: "Everyone in #{name}"
        },
        {
          name: "Members",
          description: "Members who have been active in the past."
        },
        {
          name: "Volunteers",
          description: "Folks who have volunteered here before."
        },
        {
          name: "Board",
          description: "Board Members."
        }
      ].each do |group_desc|
        group = Group.new(group_desc.merge({organization: self}))
        group.save!
      end
    end
end
