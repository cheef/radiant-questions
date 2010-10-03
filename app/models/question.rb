class Question < ActiveRecord::Base

  has_many :answers, :dependent => :destroy
  has_many :replies, :class_name => 'QuestionReply', :dependent => :destroy

  validates_presence_of :body
  validates_associated  :answers

  named_scope :random, :order => "rand()", :limit => 1

  def answers_attributes=(answers_attributes)
    answers_attributes = answers_attributes.values if answers_attributes.is_a?(Hash)
    answers_attributes.each { |answer_attributes| detect_and_update answer_attributes }
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
      return answers.build(answer_attributes) if answer_attributes['id'].blank?

      answer = answers.detect { |a| a.id == answer_attributes['id'].to_i }

      if answer
        answer.attributes = answer_attributes
        return answer.destroy if answer.should_remove?
        answer.save
      end
    end
end
