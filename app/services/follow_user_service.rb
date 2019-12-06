class FollowUserService < ApplicationService
  def initialize(following:, follower_id:)
    @following = following
    @follower_id = follower_id
  end

  private

  attr_reader :following, :follower_id

  def perform
    relationship = following.active_relationships.build follower_id: follower_id
    service_failed message: 'ユーザーのフォローに失敗しました' unless relationship&.save
  end
end
