module TagMaps
  class DestroyHandler < ApplicationHandler
    def initialize(user:, tag_id:)
      @user = user
      @tag_id = tag_id
    end

    private

    attr_reader :user, :tag_id

    def handle
      UnfollowTagService.new(user: user, tag_id: tag_id).call
    end
  end
end
