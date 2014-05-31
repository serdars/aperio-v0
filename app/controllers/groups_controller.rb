class GroupsController < ApplicationController
before_filter :require_user, :only => :join

  def join
    @group = Group.find(params[:id])

    if @group.private
      flash[:notice] = "'#{@group.name}' group is private. \
        Contact #{@group.organization.name} administrators \
        to be added to the group."
    else
      membership = Membership.new(user: current_user, group: @group)
      membership.save!

      flash[:notice] = "Successfully joined '#{@group.name}' group."
    end

    redirect_to organization_path(@group.organization)
  end
end
