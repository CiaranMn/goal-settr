class Boost < ApplicationRecord

  belongs_to :goal
  belongs_to :user, foreign_key: :booster_id
  validates :boost_type, inclusion: { in: %w[thumbs heart star] }
  validates :booster_id, :boost_type, :goal_id, presence: true

  def icon_selector
    case boost_type
      when 'thumbs'
        'far fa-thumbs-up'
      when 'heart'
        'fa fa-heart'
      when 'star'
        'fa fa-star'
    end
  end

end
