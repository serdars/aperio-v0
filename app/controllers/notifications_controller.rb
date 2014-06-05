class NotificationsController < ApplicationController
  def destroy
    Notification.find(params[:id]).destroy()

    respond_to do |format|
      format.json { render json: { } }
    end

  end
end
