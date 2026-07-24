class AnswersController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    @answer = Answer.new(answer_params)
    @answer.round = @round
    if @answer.save
      @round.increment!(:score) if @answer.correct?
    else
      flash[:alert] = @answer.errors.full_messages.to_sentence
    end
    redirect_to round_path(@round)
  end

  private

  def answer_params
    params.expect(answer: %i[question_id response])
  end
end
