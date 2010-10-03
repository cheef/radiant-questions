class QuestionsController < ApplicationController

  no_login_required
  skip_before_filter :verify_authenticity_token
  before_filter      :load_question, :only => [:reply]

  def reply
    if @question.make_reply(params[:reply_attributes], request, UserActionObserver.current_user)
      flash[:notice] = t('questions_extension.noticies.reply.success')
    else
      flash[:error]  = t('questions_extension.noticies.reply.failed')
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js do
        render :json => {
          :data  => @question.to_google_chart,
          :title => @question.body
        }
      end
    end
  end

  protected

    def load_question
      @question = Question.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to :back
    end
end
