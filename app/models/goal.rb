class Goal < ApplicationRecord

  belongs_to :user
  belongs_to :category
  has_many :boosts
  has_many :boosters, through: :boosts, source: :user
  has_many :comments
  has_many :commenters, through: :comments, source: :user
  has_many :daily_goal_mets

def self.valid_goals
  Goal.all.select { |goal| goal.start_date >= Date.current }
end

def self.goals_due_soon # Show goals due soon (class method)
  Goal.all.select { |goal| goal.due_date < 10.days.from_now }
end

def self.goals_achieved
  Goal.all.select { |goal| goal.achieved == true }
end

def self.daily_goals_met_today #number of daily goals met today
  daily_goals_met_today = DailyGoalMet.select {|dg| dg.date == Date.current }
  daily_goals_met_today.count
end

def self.daily_goals_met_total
  Goal.all.map(&:percentage_of_daily_goals_met).inject(0, :+)
end

def self.highest_streak
  Goal.all.max_by(&:daily_goal_streak)
end

def self.average_percent_daily_goals_met
  (daily_goals_met_total.to_f / valid_goals.count.to_f).to_i
end

def days_to_goal_due_date #Time to goal due date (instance method)
  (self.due_date.to_date - Date.current).to_i
end

def percentage_of_daily_goals_met
  days_since_goal_began = (Date.current - self.start_date.to_date).to_f
  percentage_successful = (self.daily_goal_mets.count.to_f / days_since_goal_began)*100
end

def daily_goal_streak
  if !daily_goal_met.yesterday
    streak = 0
  end
end

def number_of_comments #instance
  self.comments.count
end


def number_of_users_who_have_commented #Number of unique commenters (instance)
self.comments.map do |comment|
    comment.user
  end.uniq.count
end

def number_of_boosters  #instance
  self.boosts.map do |boost|
    boost.user
  end.uniq.count
end

end

# To applicationcontroller, add :set_user_time_zone. On signup user should enter their local time zone
# before_filter :set_user_time_zone
# def set_user_time_zone
#     Time.zone = current_user.time_zone
#   end
