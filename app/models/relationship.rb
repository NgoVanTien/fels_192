class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validates :followed_id, presence: true
  validates :follower_id, presence: true
  after_create :create_follow_activity
  after_destroy :create_unfollow_activity

  private
    def create_follow_activity
      Activity.create user_id: selt.follower_id, target_id: id,
        action_type: 2, target_type: 1
    end

    def create_unfollow_activity
      Activity.create user_id: selt.follower_id, target_id: id,
        action_type: 3, target_type: 1
    end
end
