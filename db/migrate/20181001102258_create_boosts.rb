class CreateBoosts < ActiveRecord::Migration[5.2]
  def change
    create_table :boosts do |t|
      t.integer :booster_id
      t.integer :goal_id
      t.string :type
      t.timestamps
    end
  end
end
