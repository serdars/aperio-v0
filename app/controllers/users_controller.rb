class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    # We register and login at the same page
    @tab = "register"
    @user = User.new
    @user_session = UserSession.new
  end

  def create
    @tab = "register"
    @user = User.new(user_params)
    if @user.save
      redirect_back_or_default root_path
    else
      # We register and login at the same page
      @user_session = UserSession.new
      render action: :new
    end
  end

  def show
    @user = User.find(params[:id]) || current_user
  end

  # def edit
  #   @user = @current_user
  # end
  #
  # def update
  #   @user = @current_user
  #   if @user.update_attributes(params[:user])
  #     flash[:notice] = "Account updated!"
  #     redirect_to account_url
  #   else
  #     render :action => :edit
  #   end
  # end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
