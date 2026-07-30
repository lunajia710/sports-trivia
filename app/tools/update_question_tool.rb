class UpdateQuestionTool < RubyLLM::Tool
  description "Updates a question in the current deck."

  param :question_id,
        type: :integer,
        desc: "The ID of the question to update"

  param :question,
        type: :string,
        desc: "The new text for the question (optional)"

  param :option_1, type: :string, desc: "First option" # rubocop:disable Naming/VariableNumber
  param :option_2, type: :string, desc: "Second option" # rubocop:disable Naming/VariableNumber
  param :option_3, type: :string, desc: "Third option" # rubocop:disable Naming/VariableNumber
  param :option_4, type: :string, desc: "Fourth option" # rubocop:disable Naming/VariableNumber

  param :correct_option,
        type: :integar,
        desc: "The correct option number, from one to four"

  def initialize(deck:)
    @deck = deck
  end

  def execute(
    question_id:,
    question:,
    option_1:,
    option_2:,
    option_3:,
    option_4:,
    correct_option:
  )
    correct_option = correct_option.to_i

    return "correct option must be between one and four" unless (1..4).cover?(correct_option)

    trivia_question = @deck.questions.find(question_id)
    responses = [option_1, option_2, option_3, option_4]

    Question.transaction do
      trivia_question.update!(question: question)
      trivia_question.options.destroy_all

      responses.each_with_index do |response, index|
        trivia_question.options.create!(
          response: response,
          is_solution: index + 1 == correct_option
        )
      end
    end

    "Updated question #{trivia_question.id} successfully."
  rescue ActiveRecord::RecordNotFound
    "Update failed: question not found in this deck."
  rescue ActiveRecord::RecordInvalid => e
    "Update failed: #{e.record.errors.full_messages.to_sentence}"
  end
end
