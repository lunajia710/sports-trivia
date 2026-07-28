class MessagesController < ApplicationController
  SYSTEM_PROMPT = "You are a trivia quiz master."

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @deck = @chat.deck
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat
      response = ruby_llm_chat.ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)
    else
    end
  end
end
