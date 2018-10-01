class CreateDailyGoalMets < ActiveRecord::Migration[5.2]
  def change
    create_table :daily_goal_mets do |t|
      t.integer :goal_id
      t.datetime :date

      t.timestamps
    end
  end
end
