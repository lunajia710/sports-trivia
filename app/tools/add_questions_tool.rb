class AddQuestionsTool < RubyLLM::Tool
  description "Generates and adds new trivia questions on a topic to the current deck."
  param :topic, type: :string, desc: "What the new questions should be about"
  param :count, type: :integer, required: false, desc: "How many to add (default 3)"

  def initialize(deck:)
    @deck = deck
  end

  def execute(topic:, count: 3) # rubocop:disable Metrics/MethodLength
    data = RubyLLM.chat
                  .with_schema(DecksController::DeckSchema)
                  .ask("Generate #{count} trivia questions about: #{topic}.\n
                      Each with 4 options, exactly one is_solution: true.")
                  .content

    Deck.transaction do
      data["questions"].each do |q|
        question = @deck.questions.create!(question: q["question"])
        q["options"].each do |o|
          question.options.create!(response: o["response"], is_solution: o["is_solution"])
        end
      end
    end

    "Added #{data['questions'].size} questions about #{topic} to the deck."
  rescue StandardError => e
    "Couldn't add questions: #{e.message}"
  end
end
