class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.text :description
      t.string :overall_goal
      t.datetime :due_date
      t.datetime :start_date 
      t.string :daily_goal
      t.integer :category_id
      t.integer :user_id
      t.timestamps
    end
  end
end
