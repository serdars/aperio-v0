class Tag < ActiveRecord::Base
  validates :name, uniqueness: true

  has_many :tag_assignments
  has_many :organizations, through: :tag_assignments, source: :taggable, source_type: 'Organization'
end
