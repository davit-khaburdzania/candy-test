class ChatgtpService
  def initialize(message = nil)
    @message = message
    @openai_client = OpenAI::Client.new
  end

  def call
    call_chatgtp(generate_messages)
  end

  def generate_messages
    current_message = { role: @message.sender, content: @message.content }

    if @message.conversation.present?
      @message.conversation.messages
              .reject { |message| message.content.blank? }
              .map { |message| { role: message.sender, content: message.content } }
              .append(current_message)
    else
      [current_message]
    end
  end

  def call_chatgtp(messages)
    response = @openai_client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: messages,
        temperature: 0.7
      }
    )

    puts(response)

    response.dig('choices', 0, 'message', 'content')
  end
end
