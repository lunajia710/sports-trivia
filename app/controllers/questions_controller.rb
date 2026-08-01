class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def destroy
    @deck = current_user.decks.find(params[:deck_id])
    @question = @deck.questions.find(params[:id])
    @chat = @deck.chat

    @question.destroy!

    redirect_to chat_path(@chat), notice: "Question deleted"
  end
end
