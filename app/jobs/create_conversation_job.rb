class CreateConversationJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    count = Conversation.count + 1
    starter_text = ChatgtpService.new.call_chatgtp([{ role: 'user', content: 'suggest one small conversation starter for bot' }])
    conversation = user.conversations.create(name: "Conversation ##{count}")

    conversation.messages.create(sender: :system, content: starter_text)
    user.notifications.create(content: 'You have a new conversation')
  end
end
