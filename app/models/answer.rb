class Answer < ActiveRecord::Base

  has_one :question

  has_many :replies, :class_name => 'AnswerReply'
  has_many :question_replies, :through => :replies, :source => :reply

  attr_accessor :should_remove

  validates_presence_of :body

  def should_remove?
    @should_remove.to_i === 1          
  end  

end
