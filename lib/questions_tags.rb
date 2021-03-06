module QuestionsTags
  include Radiant::Taggable
  include ActionView::Helpers::TagHelper

  tag "questions" do |tag|
    tag.locals.questions.map do |question|
      tag.locals.question = question
      tag.expand
    end
  end

  tag "question" do |tag|
    tag.expand
  end

  tag "question:form" do |tag|
    tag.expand unless tag.locals.question.blank?
  end

  tag "question:form:submit" do |tag|
    html_options = tag.attr.symbolize_keys
    html_options[:type] = 'submit'
    html_options[:name] = nil

    content_tag :input, nil, html_options
  end

  tag "question:form:answers" do |tag|
    tag.locals.question.answers.map do |answer|
      tag.locals.answer = answer
      tag.expand
    end
  end

  tag "question:form:answers:answer" do |tag|
    answer       = tag.locals.answer
    html_options = tag.attr.symbolize_keys
    html_options = build_answer_options(answer, html_options)
    html_options[:value] = answer.body

    content_tag :input, nil, html_options
  end

  tag "question:result" do |tag|
    tag.localstag.locals.question.result
  end

  protected

    def build_answer_options answer, html_options
      html_options[:type] = 'radio'
      html_options[:name] = "answer[#{answer.id}]"      
      html_options
    end

end