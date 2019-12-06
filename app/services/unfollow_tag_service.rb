class UnfollowTagService < ApplicationService
  def initialize(user:, tag_id:)
    @user = user
    @tag_id = tag_id
    end

  private

  attr_reader :user, :tag_id

  def perform
    tag_map = user.tag_maps.find_by tag_id: tag_id
    service_failed message: 'タグのフォロー解除に失敗しました' unless tag_map&.destroy
  end
end
