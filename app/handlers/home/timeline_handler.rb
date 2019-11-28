module Home
  class TimelineHandler < ApplicationHandler
    class TimelineResult
      attr_reader :articles, :users, :tags

      def initialize(articles:, users:, tags:)
        @articles = articles
        @users = users
        @tags = tags
      end
    end
    def initialize(visitor:, page:)
      @visitor = visitor
      @page = page
    end

    private

    attr_reader :visitor, :page

    def handle
      articles = TimelineArticlesService.new(
        visitor: visitor,
        page: page
      ).call.model
      users = TrendUsersService.new.call.model
      tags = TrendTagsService.new.call.model
      result = TimelineResult.new(
        articles: articles,
        users: users,
        tags: tags
      )
      handle_succeeded model: result
    end
  end
end
