module Articles
  class DestroyHandler < ApplicationHandler
    def initialize(user:, article_id_digest:)
      @user = user
      @article_id_digest = article_id_digest
    end

    private

    attr_reader :user, :article_id_digest

    def handle
      DeleteArticleService.new(user: user, article: article).call
    end

    def article
      @article ||= user.articles.published.find_by! id_digest: article_id_digest
    end
  end
end
