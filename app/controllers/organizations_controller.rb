class OrganizationsController < ApplicationController
  before_filter :require_user, :only => [:join, :manage, :new, :create]

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      # Add the current user to the organization
      Membership.new(user: current_user, group: @organization.default_group).save!
      Membership.new(user: current_user, group: @organization.admin_group).save!

      redirect_to organization_path(@organization)
    else
      render action: :new
    end
  end

  def index
    @organizations = Organization.all
  end

  def show
    @organization = Organization.find(params[:id])
    @group = params[:group].nil? ? @organization.default_group : Group.find(params[:group])

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

  protected
    def organization_params
      params.require(:organization).permit(:name, :description, :website)
    end
end
