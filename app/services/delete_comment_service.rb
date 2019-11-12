class DeleteCommentService < ApplicationService
  def initialize(comment:)
    @comment = comment
  end

  private

  attr_reader :comment

  def perform
    service_failed message: 'コメントの削除に失敗しました', model: comment unless comment&.destroy
  end
end