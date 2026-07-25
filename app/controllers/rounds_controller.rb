class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    answers = @round.answers
    answered_question_ids = answers.map { |answer| answer.question_id }
    @deck = @round.deck
    questions = @deck.questions
    unanswered_questions = questions.where.not(id: answered_question_ids)
    @question = unanswered_questions.first
    redirect_to deck_path(@deck) and return if @question.nil?
  end

  def create
    if current_user
      @deck = Deck.find(params[:deck_id])
      @round = @deck.rounds.create!(user: current_user)
      redirect_to round_path(@round)
    else
      redirect_to new_user_session
    end
  end
end
