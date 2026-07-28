class MessagesController < ApplicationController
  SYSTEM_PROMPT = "You are a trivia quiz master."

  def create # rubocop:disable Metrics/MethodLength
    @chat = current_user.chats.find(params[:chat_id])
    @deck = @chat.deck
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      ruby_llm_chat = RubyLLM.chat(model: "gpt-4o-mini")
      ruby_llm_chat.with_instructions(SYSTEM_PROMPT)
      response = ruby_llm_chat.ask(@message.content)
      Message.create(
        role: "assistant",
        content: response.content,
        chat: @chat
      )
      # @chat.update_deck_from_message
      redirect_to chat_messages_path(@chat)
    else
      render "chats/show", status: 422
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
