class GroupsController < ApplicationController
before_filter :require_user, :only => :join

  def show
    @group = Group.find(params[:id])
    redirect_to organization_path(@group.organization)
  end

  def join
    @group = Group.find(params[:id])
    @user = params[:member_name] ? User.find_by_email(params[:member_name]) : current_user

    if @group.private
      # current_user needs to be an admin to perform the operation
      if @group.organization.admin?(current_user)
        membership = Membership.new(user: current_user, group: @group)
        membership.save!

        if params[:member_name]
          flash[:notice] = "'#{@user.email}' is successfully added to '#{@group.name}' group."
        else
          flash[:notice] = "Successfully joined '#{@group.name}' group."
        end
      else
        flash[:notice] = "'#{@group.name}' group is private. \
          Contact #{@group.organization.name} administrators \
          to be added to the group."
        end
    else
      membership = Membership.new(user: current_user, group: @group)
      membership.save!

      flash[:notice] = "Successfully joined '#{@group.name}' group."
    end

    redirect_to organization_path(@group.organization, group: @group)
  end
end
