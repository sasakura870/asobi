class CreateCommentService < ApplicationService
  def initialize(user:, article:, content:)
    @user = user
    @article = article
    @content = content
  end

  private

  attr_reader :user, :article, :content

  def perform
    if article.nil?
      service_failed message: 'コメントに失敗しました'
      return
    end

    params = { article_id: article.id, content: content }
    comment = user.comments.new(params)
    service_failed message: 'コメントに失敗しました', model: comment unless comment.save
  end
end
