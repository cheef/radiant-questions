class CreateAnswerResults < ActiveRecord::Migration
  def self.up
    create_table :answer_results do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :answer_results
  end
end
