class SearchQuestionsTool < RubyLLM::Tool
  description "Searches questions in the current deck by keyword."
  param :query, desc: "The keyword to search for"

  def initialize(deck:)
    @deck = deck
  end

  def execute(query:)
    questions = @deck.questions.joins(:options).distinct
    query.split.each do |word|
      questions = questions.where(
        "questions.question ILIKE :q OR options.response ILIKE :q", q: "%#{word}%"
      )
    end
    return "No questions found for '#{query}'" if questions.empty?

    questions.map do |question|
      { id: question.id, question: question.question, options: question.options.map(&:response) }
    end
  end
end
