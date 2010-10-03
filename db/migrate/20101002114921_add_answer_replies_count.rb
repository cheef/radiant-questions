class AddAnswerRepliesCount < ActiveRecord::Migration
  def self.up
    add_column 'answers', 'answer_replies_count', :integer, :default => 0

    Answer.reset_column_information
    Answer.find(:all).each {|a| a.update_attribute('answer_replies_count', a.replies.length) }
  end

  def self.down
    remove_column 'answers', 'answer_replies_count'
  end
end
