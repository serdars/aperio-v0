class Organization < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :tag_assignments, as: :taggable
  has_many :tags, through: :tag_assignments
end
