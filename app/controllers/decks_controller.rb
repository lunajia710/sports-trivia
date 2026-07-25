class DecksController < ApplicationController
  def index
    @decks = Deck.all
  end

  def show
    @deck = Deck.find(params[:id])
    @leaderboard = @deck.rounds.includes(:user).order(score: :desc).limit(10)
  end
end
