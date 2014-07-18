class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @tab = "login"
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_back_or_default root_path
    else
      @user = User.new
      render :template => "users/new"
    end
  end

  def destroy
    current_user_session.destroy

    respond_to do |format|
      format.html { redirect_back_or_default root_path }
      format.json { render json: { uri: root_path() } }
    end
  end
end
