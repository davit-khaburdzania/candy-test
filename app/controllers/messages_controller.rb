class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @conversation = Conversation.find_by(id: msg_params[:conversation_id])
    @message = Message.new(content: msg_params[:content], conversation: @conversation, sender: :user)
    chatgtp_response = ChatgtpService.new(@message).call

    if @conversation.blank?
      @conversation = current_user.conversations.create(name: @message.content[0, 30])
      @message.conversation = @conversation
      CreateConversationJob.set(wait: 10.seconds).perform_later(current_user.id)
    end

    @message.save
    @conversation.messages.create(content: chatgtp_response, sender: :system)

    redirect_to @conversation
  end

  private

  def msg_params
    params.require(:message).permit(:content, :conversation_id)
  end
end
