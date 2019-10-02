class Relationship < ApplicationRecord
  belongs_to :following, class_name: 'User'
  belongs_to :follower, class_name: 'User'

  validates :following_id, presence: true
  validates :follower_id, presence: true
  validates :following_id, uniqueness: { scope: :follower_id }
  validate :cannot_follow_yourself, :cannot_follow_temporary

  private

  def cannot_follow_yourself
    errors.add(:follow_yourself, '自分自身はフォローできません') if following_id == follower_id
  end

  def cannot_follow_temporary
    errors.add(:follow_temporary, '仮登録ユーザーはフォローできません') if User.find_by(id: follower_id)&.temporary?
  end
end
