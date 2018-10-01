class Comment < ApplicationRecord

  belongs_to :goal
  belongs_to :user, foreign_key: :commenter_id

end
