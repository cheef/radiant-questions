class Answer < ActiveRecord::Base

  has_one :question

  attr_accessor :should_destroy

  validates_presence_of :body

  def should_destroy?
    @should_destroy.to_i === 1          
  end

end
