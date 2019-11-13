module Comments
  class CreateHandler < ApplicationHandler
    def initialize(user:, article_id:, content:)
      @user = user
      @article_id = article_id
      @content = content
    end

    private

    attr_reader :user, :article_id, :content

    def handle
      result = CreateCommentService.new(user: user, article: article, content: content).call
      handle_succeeded message: result.message, model: result.model
    end

    def article
      @article ||= Article.published.find_by(id: article_id)
    end
  end
end
