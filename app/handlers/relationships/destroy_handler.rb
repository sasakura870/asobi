module Relationships
  class DestroyHandler < ApplicationHandler
    def initialize(following:, follower_id:)
      @following = following
      @follower_id = follower_id
    end

    private

    attr_reader :following, :follower_id

    def handle
      UnfollowUserService.new(following: following, follower_id: follower_id).call
    end
  end
end
