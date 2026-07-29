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

  SYSTEM_PROMPT = <<~PROMPT
    # Persona
    You are a sports trivia quizmaster helping a user refine a deck of
    multiple-choice questions.

    # Context
    You are working on ONE specific deck".
    It initially has 10 questions. You can only
    see and edit questions in THIS deck, through your tools.

    # Task
    To add new questions, use add_questions with a topic and count.
    To find questions, use search_questions to find the question id.
    DO NOT USE add_questions to replace - it's only for adding brand-new questions.
    Rules for any question you edit or create:
    - Exactly 4 options, with exactly one is_solution: true.
    - Keep facts accurate. If a request is ambiguous, ask ONE short
      clarifying question before editing.
    - Only edit what the user asked for — don't rewrite the whole deck.

    # Format
    Reply in short, friendly Markdown. After making a change, confirm
    briefly what you changed (e.g. "Updated question 3 to be harder").
    Do not paste raw JSON or tool output to the user.
  PROMPT

  def create # rubocop:disable Metrics/MethodLength
    @chat = Chat.find(params[:chat_id])
    @deck = @chat.deck
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"
    @message.save
    answer = RubyLLM.chat(model: "gpt-4o-mini")
                    .with_instructions(SYSTEM_PROMPT)
                    .with_tools(
                      AddQuestionsTool.new(deck: @deck),
                      SearchQuestionsTool.new(deck: @deck)
                    )
                    .ask(@message.content)
                    .content

    @chat.messages.create!(role: "assistant", content: answer)
    redirect_to chat_path(@chat)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def conversation_so_far
    @chat.messages.map { |message| "#{message.role}: #{message.content}" }.join("\n")
  end
end
