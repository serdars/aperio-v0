class Organization < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :tag_assignments, as: :taggable
  has_many :tags, through: :tag_assignments
  has_many :groups

  after_create :create_groups

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
