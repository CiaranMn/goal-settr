class Category < ApplicationRecord

  has_many :goals
  has_many :users, through: :goals

  def self.most_popular
    Category.all.max_by(&:num_goals)
  end

  def self.goals_leaderboard
    ranking = Category.all.sort_by(&:num_goals)
    ranking.each_with_object({}) do |category, counter|
      counter[category.name] = category.num_goals
    end
  end

  def num_goals
    goals.count
  end

end
