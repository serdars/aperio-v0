class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @conversation }
    end
  end
end
