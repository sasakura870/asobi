class UnfollowUserService < ApplicationService
  def initialize(following:, follower_id:)
    @following = following
    @follower_id = follower_id
  end

  private

  attr_reader :following, :follower_id

  def perform
    relationship = following.active_relationships.find_by follower_id: follower_id
    service_failed message: 'フォロー解除に失敗しました' unless relationship&.destroy
  end
end
