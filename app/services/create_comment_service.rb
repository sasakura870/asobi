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
    if comment.save
      service_succeeded message: 'コメントしました!', model: article
    else
      service_failed message: 'コメントに失敗しました', model: comment
    end
  end
end
