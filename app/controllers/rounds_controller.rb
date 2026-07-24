class RoundsController < ApplicationController
  def show
    @round = Round.find(params[:id])
    answers = @round.answers
    answered_question_ids = answers.map { |answer| answer.question_id }
    @deck = @round.deck
    questions = @deck.questions
    unanswered_questions = questions.where.not(id: answered_question_ids)
    @question = unanswered_questions.first
    # redirect_to deck_path(@deck) and return if @question.nil?
  end
end
