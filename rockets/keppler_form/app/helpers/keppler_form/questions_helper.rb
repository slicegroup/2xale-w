module QuestionsHelper
  def question_type(question)
    case question.ask_type
    when "short_text"
      render 'app/front/poll/short_text', question: question
    when "long_text"
      render "app/front/poll/long_text", question_type: question.id.to_s, question: question
    when "yes_or_not"
      render "app/front/poll/yes_or_not", question: question
    when "simple_selection"
      render "app/front/poll/simple_selection", question: question
    when "multiple_selection"
      render "app/front/poll/multiple_selection", question: question
    end
  end
end
