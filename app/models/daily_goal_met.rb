class DailyGoalMet < ApplicationRecord

  belongs_to :goal
  has_one :user, through: :goal

  validates :date, :goal_id, presence: true

  def self.delete_all_from_month(goal, month)
    goal.daily_goal_mets.select { |d| d.date.month == month.to_i }.each do |dgm|
      dgm.destroy
    end
  end

end
