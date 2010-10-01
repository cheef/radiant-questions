module QuestionsTags
  include Radiant::Taggable
  include ActionView::Helpers::TagHelper

  tag "questions" do |tag|
    tag.locals.questions.map do |question|
      tag.locals.question = question
      tag.expand
    end
  end

  desc %{ Expands question related tags }
  tag "question" do |tag|
    tag.expand
  end

  tag "question:body" do |tag|
    tag.locals.question.body unless tag.locals.question.blank?
  end

  tag "question:if_exists" do |tag|
    tag.expand unless tag.locals.question.blank?  
  end

  desc %{ Find question by id or scope }
  tag "question:find" do |tag|
    tag.locals.question = find_by_id(tag) || find_by_scope(tag)
    tag.expand
  end

  tag "question:reply" do |tag|
    tag.expand
  end

  tag "question:reply:form" do |tag|
    unless tag.locals.question.blank?
      html_options = {}
      html_options[:class] = 'b-question-reply-form'
      html_options.merge!(tag.attr.symbolize_keys)
      content_tag :form, tag.expand, 
        :action       => "/questions/#{tag.locals.question.id}/reply",
        :method       => :post,
        :html_options => html_options
    end
  end

  tag "question:reply:form:submit" do |tag|
    html_options = tag.attr.symbolize_keys
    html_options[:type] = 'submit'
    html_options[:name] = nil

    content_tag :input, nil, html_options
  end

  tag "question:reply:form:answers" do |tag|
    tag.expand unless tag.locals.question.answers.blank?  
  end

  tag "question:reply:form:answers:each" do |tag|
    tag.locals.question.answers.map do |answer|
      tag.locals.answer = answer
      tag.expand
    end
  end

  tag "question:reply:form:answers:each:answer" do |tag|
    tag.expand unless tag.locals.answer.blank?
  end

  tag "question:reply:form:answers:each:answer:input" do |tag|
    answer       = tag.locals.answer
    html_options = tag.attr.symbolize_keys
    html_options = build_answer_radio_input_options(answer, html_options)

    content_tag :input, nil, html_options
  end

  tag "question:reply:form:answers:each:answer:label" do |tag|
    answer       = tag.locals.answer
    html_options = tag.attr.symbolize_keys
    html_options = build_answer_label_options(answer, html_options)

    content_tag :label, answer.body, html_options
  end

  tag "question:result" do |tag|
    tag.locals.question.result
  end

  protected

    def build_answer_label_options answer, html_options
      html_options[:for] = "question_#{answer.id}"
      html_options
    end

    def build_answer_radio_input_options answer, html_options
      html_options[:type]  = 'radio'
      html_options[:name]  = "reply_attributes"

      build_answer_input_options answer, html_options
    end

    def build_answer_input_options answer, html_options
      html_options[:value] = answer.id
      html_options[:id]    = "question_#{answer.id}"
      html_options
    end

    def find_by_id tag
      return nil if tag.attr['id'].blank?
      Question.find_by_id tag.attr['id']
    end

    def find_by_scope tag
      return nil if tag.attr['scope'].blank?
      scope = tag.attr['scope']
      raise ArgumentError, "Undefined scope" unless Question.respond_to?(scope)
      Question.send(scope).find(:first)
    end

end