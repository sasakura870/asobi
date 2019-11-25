module Comments
  class DestroyHandler < ApplicationHandler
    def initialize(user:, comment_id:)
      @user = user
      @comment_id = comment_id
    end

    private

    attr_reader :user, :comment_id

    def handle
      result = DeleteCommentService.new(comment: comment).call
      handle_succeeded message: result.message, model: result.model
    end

    def comment
      @comment ||= user.comments.find_by! id: comment_id
    end
  end
end
