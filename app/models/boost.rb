class Boost < ApplicationRecord

  belongs_to :goal
  belongs_to :user, foreign_key: :booster_id

end
