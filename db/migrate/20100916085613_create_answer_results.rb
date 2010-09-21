class CreateAnswerResults < ActiveRecord::Migration
  def self.up
    create_table :answer_results do |t|
      t.integer :answer_id
      t.integer :question_id
      t.integer :user_id
      t.text    :user_data

      t.timestamps
    end
  end

  def self.down
    drop_table :answer_results
  end
end
