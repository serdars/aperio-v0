class NotificationsController < ApplicationController
  def notify
    Notification.destroy(params[:ids])

    respond_to do |format|
      format.json { render json: { } }
    end
  end
end
