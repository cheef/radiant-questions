class QuestionReply < ActiveRecord::Base

  serialize :reply_data, QuestionReplyData

  belongs_to :question
  belongs_to :user

  has_many :answers_replies, :class_name => 'AnswerReply', :foreign_key => 'reply_id', :dependent => :destroy
  has_many :answers, :through => :answers_replies

#  validates_presence_of :reply_data
#  validates_presence_of :answers_replies
  validates_associated  :question

  def request=(request)
    reply_data = QuestionReplyData.new
    reply_data.user_ip      = request.remote_ip
    reply_data.http_referer = request.env["HTTP_REFERER"]
    reply_data.user_agent   = request.env["HTTP_USER_AGENT"]
  end

  def reply_attributes=(reply_attributes)
    answers_replies.build(:answer_id => reply_attributes)  
  end

end
