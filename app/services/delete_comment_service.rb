class DeleteCommentService < ApplicationService
  def initialize(comment:)
    @comment = comment
  end

  private

  attr_reader :comment

  def perform
    if comment&.destroy
      service_succeeded message: 'コメントを削除しました'
    else
      service_failed message: 'コメントの削除に失敗しました', model: comment
    end
  end
end
