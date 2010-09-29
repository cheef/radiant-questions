class Question < ActiveRecord::Base

  has_many :answers, :dependent => :destroy

  validates_presence_of :body
  validates_associated  :answers

  named_scope :random, :order => "rand()", :limit => 1

  def answers_attributes=(answers_attributes)
    answers_attributes.each { |number, answer_attributes| detect_answer answer_attributes }
  end
  
  protected

    def detect_answer answer_attributes
      return add_new_answer(answer_attributes) if answer_attributes['id'].blank?

      answer = answers.detect { |a| a.id == answer_attributes['id'].to_i }
      answer.update_attributes(answer_attributes) if answer
    end

    def add_new_answer answer_attributes
      answers << Answer.new(answer_attributes)
    end
end
