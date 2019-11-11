module Favorites
  class DestroyHandler < ApplicationHandler
    def initialize(user:, article_id:)
      @user = user
      @article_id = article_id
    end

    private

    attr_reader :user, :article_id

    def handle
      UnfavoriteService.new(user: user, article: article).call
    end

    def article
      @article ||= Article.find_by(id: article_id)
    end
  end
end
