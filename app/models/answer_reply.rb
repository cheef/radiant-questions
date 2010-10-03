class AnswerReply < ActiveRecord::Base

  belongs_to :answer, :counter_cache => true
  belongs_to :reply, :class_name => 'QuestionReply'

end
