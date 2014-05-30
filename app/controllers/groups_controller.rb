class GroupsController < ApplicationController
before_filter :require_user, :only => :join

  def join
    @group = Group.find(params[:id])

    membership = Membership.new(user: current_user, group: @group)
    membership.save!

    flash[:notice] = "Successfully joined '#{@group.name}' group."

    redirect_to organization_path(@group.organization)
  end
end
