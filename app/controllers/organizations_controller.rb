class OrganizationsController < ApplicationController
  before_filter :require_user, :only => :join

  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @organization }
    end
  end

  def join
    @organization = Organization.find(params[:id])

    membership = Membership.new(user: current_user, group: @organization.default_group)
    membership.save!

    flash[:notice] = "Successfully joined '#{@organization.name}'."

    redirect_to action: :show
  end

  def manage
    @organization = Organization.find(params[:id])
    @group = if params[:group]
      Group.find(params[:group])
    else
      @organization.default_group
    end

    if @organization.admin?(current_user)
      respond_to do |format|
        format.html
        format.json { render json: @organization }
      end
    else
      flash[:notice] = "You need to be an admin in order to manage '#{@organization.name}'."

      redirect_to action: :show
    end
  end
end
