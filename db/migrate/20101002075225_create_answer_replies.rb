class CreateAnswerReplies < ActiveRecord::Migration
  def self.up
    create_table :answer_replies do |t|
      t.integer :answer_id
      t.integer :reply_id
    end
  end

  def self.down
    drop_table :answer_replies
  end
end
