class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :conversations
  has_many :messages
  has_many :notifications

  acts_as_authentic do |c|
    c.validate_login_field = false

    # http://stackoverflow.com/questions/23031902/rails-4-1-0-and-authlogic-bcrypt-issue
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def organizations
    groups.map{|g| g.organization}.uniq
  end

  def memberships_by_org
    collection = { }

    memberships.each do |membership|
      collection[membership.group.organization] ||= [ ]
      collection[membership.group.organization] << membership
    end

    collection
  end
end
