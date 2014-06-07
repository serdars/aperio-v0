class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @conversation }
    end
  end

  def new
    @conversation = Conversation.new
    @organization = Organization.find(params[:organization])
  end

  def create
    conversation = Conversation.new({
      title: params[:title],
      user: current_user,
      group: Group.find(params[:group])
    })

    conversation.save!

    Message.new({
      conversation: conversation,
      user: current_user,
      body: params[:message]
    }).save!

    respond_to do |format|
      format.html { redirect_to conversation_path(conversation)}
      format.json { render json: { uri: conversation_path(conversation) } }
    end
  end

  def post
    @message = Message.new({
      conversation: Conversation.find(params[:id]),
      user: current_user,
      body: params[:message]
    })

    @message.save!

    respond_to do |format|
      format.html { render partial: "conversations/message", locals: {message: @message} }
      format.json { render json: @message }
    end
  end
end
