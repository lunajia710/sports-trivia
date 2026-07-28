class DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.new
  end

  def create
    # user types name of deck and creates a new deck with that name
    @deck = Deck.new(deck_params)
    @deck.user = current_user

    if @deck.save
      redirect_to deck_path(@deck)
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
