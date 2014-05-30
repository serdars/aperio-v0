class User < ActiveRecord::Base
  has_many :memberships
  has_many :groups, through: :memberships

  acts_as_authentic do |c|
    c.validate_login_field = false

    # http://stackoverflow.com/questions/23031902/rails-4-1-0-and-authlogic-bcrypt-issue
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end
end
