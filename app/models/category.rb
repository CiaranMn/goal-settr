class Category < ApplicationRecord

  has_many :goals
  has_many :users, through: :goals

  def self.most_popular
    Category.all.max_by(&:num_goals)
  end

  def self.scoreboard
    ranking = Category.all.sort_by { |category| yield(category) }.reverse
    ranking.each_with_object({}) do |category, counter|
      counter[category.name] = yield(category)
    end
  end

  def self.goals_scoreboard
    scoreboard(&:num_goals)
  end

  def self.daily_goal_mets_scoreboard
    scoreboard(&:daily_goal_mets)
  end

  def self.avg_percent_daily_goal_mets_scoreboard
    scoreboard(&:percent_daily_goal_mets)
  end

  def daily_goal_mets
    # needs to check interaction with goals
    goals.map(&:daily_goal_mets).inject(0, :+)
  end

  def avg_percent_daily_goal_mets
      # needs to check interaction with goals
    goals.map(&:percent_daily_goal_mets).inject(0, :+).to_f / goals.count
  end

  def num_goals
    goals.count
  end

end
