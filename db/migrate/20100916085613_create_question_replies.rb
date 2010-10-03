class CreateQuestionReplies < ActiveRecord::Migration
  def self.up
    create_table :question_replies do |t|
      t.integer :question_id
      t.integer :user_id
      t.text    :reply_data

      t.timestamps
    end
  end

  def self.down
    drop_table :question_replies
  end
end