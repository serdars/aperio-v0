module OrganizationsHelper
  def membership(group, user)
    Membership.where(group: group, user: user).first
  end
end
