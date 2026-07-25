class AnswersController < ApplicationController
  def create
    @round = Round.find(params[:round_id])
    @answer = Answer.new(answer_params)
    @answer.round = @round
    @question = @answer.question
    if @answer.save
      @round.increment!(:score) if @answer.correct?
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to round_path(@round) }
      end
    else
      flash[:alert] = @answer.errors.full_messages.to_sentence
      redirect_to round_path(@round)
    end
    # turbo stream right or wrong
    # add a next button which link_to round_path(@round)
    # create.turbo_stream.erb
    # -> copy paste the 4 button layout
    # -> logic for right / wrong styling
    # -> add a link_to round_path
  end

  private

  def answer_params
    params.expect(answer: %i[question_id response])
  end
end
