module Home
  class IndexHandler < ApplicationHandler
    class IndexResult
      attr_reader :articles, :users, :tags

      def initialize(articles:, users:, tags:)
        @articles = articles
        @users = users
        @tags = tags
      end
    end

    def initialize; end

    private

    def handle
      articles = TrendArticlesService.new.call.model
      users = TrendUsersService.new.call.model
      tags = TrendTagsService.new.call.model
      result = IndexResult.new(
        articles: articles,
        users: users,
        tags: tags
      )
      handle_succeeded model: result
    end
  end
end
