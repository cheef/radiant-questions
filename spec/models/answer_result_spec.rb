require File.dirname(__FILE__) + '/../spec_helper'

describe AnswerResult do
  before(:each) do
    @answer_result = AnswerResult.new
  end

  it "should be valid" do
    @answer_result.should be_valid
  end
end
