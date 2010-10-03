require File.dirname(__FILE__) + '/../spec_helper'

describe AnswerReply do
  before(:each) do
    @answer_reply = AnswerReply.new
  end

  it "should be valid" do
    @answer_reply.should be_valid
  end
end
