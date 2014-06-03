class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships
  has_many :conversations
  has_many :messages

  acts_as_authentic do |c|
    c.validate_login_field = false

    # http://stackoverflow.com/questions/23031902/rails-4-1-0-and-authlogic-bcrypt-issue
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

  def groups_by_org
    collection = { }

    groups.each do |group|
      collection[group.organization] ||= [ ]
      collection[group.organization] << group
    end

    collection
  end
end
