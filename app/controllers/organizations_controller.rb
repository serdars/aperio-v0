class OrganizationsController < ApplicationController
  def show
    @organization = Organization.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @organization }
    end
  end
end
