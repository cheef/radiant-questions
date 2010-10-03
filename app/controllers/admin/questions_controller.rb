class Admin::QuestionsController < Admin::ResourceController

  def new
    @question = Question.new
    @question.answers.build
  end

end
