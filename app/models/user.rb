class User < ApplicationRecord

  has_many :goals
  has_many :boosts_received, through: :goals, source: :boosts
  has_many :comments_received, through: :goals, source: :comments
  has_many :boosts_given, class_name: "Boost", foreign_key: :booster_id
  has_many :comments_given, class_name: "Comment", foreign_key: :commenter_id
  has_many :daily_goal_mets, through: :goals

  validates :name, presence: true

  def self.scoreboard
    ranking = User.all.sort_by { |user| yield(user) }.reverse
    ranking.each_with_object({}) do |user, counter|
      counter[user.name] = yield(user)
    end
  end

  def self.boosts_given_scoreboard
    scoreboard(&:num_boosts_given)
  end

  def self.comments_given_scoreboard
    scoreboard(&:num_comments_given)
  end

  def self.boosts_received_scoreboard
    scoreboard(&:num_boosts_received)
  end

  def self.comments_received_scoreboard
    scoreboard(&:num_comments_received)
  end

  def self.most_supportive
    User.all.max_by(&:num_boosts_given)
  end

  def self.most_talkative
    User.all.max_by(&:num_comments_given)
  end

  def self.most_consistent
    User.all.max_by(&:percent_daily_goals_met)
  end

  def self.most_popular
    User.all.max_by { |user| user.num_boosts_received + user.num_comments_received }
  end

  def num_boosts_given
    boosts_given.count
  end

  def num_comments_given
    comments_given.count
  end

  def num_boosts_received
    boosts_received.count
  end

  def num_comments_received
    comments_received.count
  end

  def goals_achieved
    # needs to call on goals for total
    goals.select { |goal| goal.achieved == true }
  end

  def daily_goals_met
    # needs to check interaction with goals
    goals.map(&:daily_goals_met).inject(0, :+)
  end

  def percent_daily_goals_met
    # needs to check interaction with goals
    goals.map(&:percent_daily_goals_met).inject(0, :+).to_f / goals.count
  end

  def num_unique_commenters
    # needs to check interaction with goals
    goals.map(&:unique_commenters).uniq
  end

  def current_streak
    # needs to check interaction with goals
    goals.max_by(&:current_streak).current_streak
  end

end
