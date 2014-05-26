class GlobalController < ApplicationController
  before_filter :require_no_user, :only => [:login]

  def home
    render
  end
end
