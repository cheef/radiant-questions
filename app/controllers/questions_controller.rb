class QuestionsController < ApplicationController

  skip_before_filter :verify_authenticity_token
  before_filter :load_question, :only => [:reply]

  def reply
    @question.make_reply(params[:reply_attributes], request)
  end

  protected

    def load_question
      @question = Question.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to :back
    end
end
