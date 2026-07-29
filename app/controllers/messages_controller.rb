class MessagesController < ApplicationController
  class DeckSchema < RubyLLM::Schema
    array :questions do
      object do
        string :question, description: "The trivia question text"
        array :options do
          object do
            string  :response,    description: "The answer option text"
            boolean :is_solution, description: "True for the one correct option, false otherwise"
          end
        end
      end
    end
  end

  SYSTEM_PROMPT = "You are a sports trivia master. \n
                  I am a user who want your help make interesting trivia deck to play with friends. \n
                  You should help me refine a deck questions.\n
                  Each question must have 4 options with only 1 is_solution: ture"

  def create # rubocop:disable Metrics/MethodLength
    @chat = Chat.find(params[:chat_id])
    @deck = @chat.deck
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      data = RubyLLM.chat(model: "gpt-4o-mini")
                    .with_instructions(SYSTEM_PROMPT)
                    .with_schema(DeckSchema)
                    .ask(@message.content)
                    .content
      Message.create(role: "assistant", content: data, chat: @chat)
      render "chats/show"
    else
      render "chats/show", status: 422
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
