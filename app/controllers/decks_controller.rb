class DecksController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
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

  def index
    @decks = Deck.all
    decks_by_rounds = Deck.left_joins(:rounds).group(:id).order("COUNT(rounds.id) DESC")
    @top_decks = decks_by_rounds.limit(5)
  end

  def new
    @deck = Deck.new
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.user = current_user
    if @deck.save
      create_deck_from_ai
      create_chat_with_first_message
      redirect_to chat_path(@chat)
    else
      render :new, status: 422
    end
  end

  def show
    @deck = Deck.find(params[:id])
    @leaderboard = @deck.rounds.includes(:user).order(score: :desc).limit(10)
  end

  private

  def deck_params
    params.require(:deck).permit(:title)
  end

  def create_deck_from_ai # rubocop:disable Metrics/MethodLength
    data = RubyLLM.chat.with_schema(DeckSchema).ask("create a deck about #{@deck.title}\n
    with 10 questions. Each question with 4 options, only 1 is_solution: true. ").content
    data["questions"].each do |q|
      question = Question.new(question: q["question"])
      question.deck = @deck
      question.save
      q["options"].each do |o|
        option = Option.new(response: o["response"], is_solution: o["is_solution"])
        option.question = question
        option.save
      end
    end
  end

  def create_chat_with_first_message
    @chat = Chat.new
    @chat.deck = @deck
    @chat.save
    @chat.messages.create!(role: "assistant", content: "Here's your #{@deck.title} deck.\n
      I created 10 questions for now.\n
      How do you want to refine it?")
  end
end

# provide feedback to update the deck
