class FollowTagService < ApplicationService
  def initialize(user:, tag_id:)
    @user = user
    @tag_id = tag_id
    end

  private

  attr_reader :user, :tag_id

  def perform
    tag_map = user.tag_maps.build tag_id: tag_id
    service_failed message: 'タグのフォローに失敗しました' unless tag_map&.save
  end
end
