class GroupsController < ApplicationController
before_filter :require_user, :only => :join

  def show
    @group = Group.find(params[:id])
    redirect_to organization_path(@group.organization)
  end

  def join
    @group = Group.find(params[:id])
    @user = params[:member_name] ? User.find_by_email(params[:member_name]) : current_user

    if @group.private && !@group.organization.admin?(current_user)
      flash[:notice] = "'#{@group.name}' group is private. \
        Contact #{@group.organization.name} administrators \
        to be added to the group."
    elsif @group.member?(@user)
      flash[:notice] = "'#{@user.email}' is already a member of '#{@group.name}'"
    else
      membership = Membership.new(user: @user, group: @group)
      membership.save!

      if params[:member_name]
        flash[:notice] = "'#{@user.email}' is successfully added to '#{@group.name}' group."
      else
        flash[:notice] = "Successfully joined '#{@group.name}' group."
      end
    end

    if params[:member_name]
      redirect_to organization_manage_path(@group.organization, group: @group)
    else
      redirect_to organization_path(@group.organization, group: @group)
    end
  end
end
