class User < ApplicationRecord

  has_many :goals
  has_many :boosts_received, class_name: "Boost", through: :goals
  has_many :boosts_given, class_name: "Boost", foreign_key: :booster_id
  has_many :comments_given, class_name: "Comment", foreign_key: :commenter_id
  has_many :comments_received, through: :goals, source: :comments
  has_many :daily_goal_mets, through: :goals

end
