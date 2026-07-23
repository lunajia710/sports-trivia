class Answer < ApplicationRecord
  belongs_to :round
  belongs_to :question
  validates :response, presence: true
  # one answer per question per round
  validates :question_id, uniqueness: { scope: :round_id }
  validate  :question_belongs_to_rounds_deck

  def correct?
    solution = question.options.find_by(is_solution: true)
    response == solution.response
  end

  private

  def question_belongs_to_rounds_deck
    return if round.nil? || question.nil?

    errors.add(:question, "is not part of this round's deck") unless question.deck_id == round.deck_id
  end
end
