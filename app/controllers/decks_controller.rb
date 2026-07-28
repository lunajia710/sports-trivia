class DecksController < ApplicationController
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
  end

  def new
    @deck = Deck.new
  end

  def create # rubocop:disable Metrics/MethodLength
    # user types name of deck and creates a new deck with that name
    @deck = Deck.new(deck_params)
    @deck.user = current_user
    data = RubyLLM.chat(model: "gpt-4o-mini")
                  .with_schema(DeckSchema)
                  .ask("Generate 10 questions about: #{@deck.title}. Each question must have 4 options with only 1 is_solution: ture") # rubocop:disable Layout/LineLength
                  .content

    if @deck.save
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
      redirect_to decks_path
    else
      render :new, status: 422
    end
    # in response to user givcing deck name
    # create a chat with four questions and four answers per question, one correct, three incorrect
    # @chat = RubyLLM.chat
    # create a message with the prompt to create four questions and four answers per question, one
  end

  def show
    @deck = Deck.find(params[:id])
    @leaderboard = @deck.rounds.includes(:user).order(score: :desc).limit(10)
  end

  private

  def deck_params
    params.require(:deck).permit(:title)
  end
end

# provide feedback to update the deck
