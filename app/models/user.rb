class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

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

  def newest_goal
    self.try(:goals).first.name
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
    User.all.max_by(&:percent_daily_goal_mets)
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
    goals.select { |goal| goal.achieved == true }
  end

  def goals_achieved_count
    goals_achieved.count
  end

  def daily_goal_mets_count
    return 0 if goals.empty?
    goals.map { |goal| goal.daily_goal_mets.count }.inject(0, :+)
  end

  def active_goals
    goals.select(&:active?)
  end

  def percent_daily_goal_mets
    return 0 if goals.empty?
    active_goals.map(&:percentage_of_daily_goals_met).inject(0, :+).to_f / active_goals.count.to_f
  end

  def unique_commenters
    return 0 if goals.empty?
    goals.map(&:unique_commenters).uniq
  end

  def number_of_boosters
    return 0 if goals.empty?
    goals.map(&:number_of_boosters).inject(0, :+)
  end

  def current_streak
    return 0 if goals.empty?
    # needs to check interaction with goals
    goals.max_by(&:daily_goal_streak)
  end

  def record_streak
    return 0 if goals.empty?
    goals.max_by(&:longest_daily_goal_streak)
  end

  def current_streak_count
    # needs to check interaction with goals
    return 0 if goals.empty?
      current_streak.daily_goal_streak
  end

  def record_streak_count
    return 0 if goals.empty?
    record_streak.longest_daily_goal_streak
  end

end
