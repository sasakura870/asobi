module Drafts
  class DestroyHandler < ApplicationHandler
    def initialize(user:, article_id:)
      @user = user
      @article_id = article_id
    end

    private

    attr_reader :user, :article_id

    def handle
      DeleteArticleService.new(user: user, article: article).call
    end

    def article
      @article ||= user.articles.draft.find_by id: article_id
    end
  end
end
