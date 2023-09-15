class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
    @conversation = Conversation.new
    @message = @conversation.messages.new
  end

  def show
    @conversation = Conversation.find(params[:id])
    @conversations = current_user.conversations
    @messages = @conversation.messages
    @message = Message.new(conversation: @conversation)

    render 'index'
  end
end
