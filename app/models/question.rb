class Question < ActiveRecord::Base

  has_many :answers, :dependent => :destroy
  has_many :replies, :class_name => 'QuestionReply', :dependent => :destroy

  validates_presence_of :body
  validates_associated  :answers

  named_scope :random, :order => "rand()", :limit => 1

  def answers_attributes=(answers_attributes)
    answers_attributes.each { |number, answer_attributes| detect_and_update answer_attributes }
  end

  def make_reply(reply_attributes, request, user = nil)
    replies.create \
      :request          => request,
      :reply_attributes => reply_attributes,
      :user             => user
  end

  def to_google_chart
    answers.map {|a| [a.body, a.replies.count] }  
  end
  
  protected

    def detect_and_update answer_attributes
      return add_new_answer(answer_attributes) if answer_attributes['id'].blank?

      answer = answers.detect { |a| a.id == answer_attributes['id'].to_i }
      answer.update_attributes(answer_attributes) if answer
    end

    def add_new_answer answer_attributes
      answers << Answer.new(answer_attributes)
    end
end
