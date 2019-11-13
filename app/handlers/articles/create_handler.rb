module Articles
  class CreateHandler < ApplicationHandler
    def initialize(user:, params:, tag_names:)
      @user = user
      @params = params
      @tag_names = tag_names
    end

    private

    attr_reader :user, :article, :params, :tag_names

    def handle
      ActiveRecord::Base.transaction do
        tag_service = ListupTagService.new(tag_names: tag_names)
        tag_service.call
        article_service = CreateArticleService.new(
          user: user,
          params: params,
          tag_list: tag_service.result
        )
        article_service.call
        @article = article_service.result
      end
    end

    def commit_data
      article
    end
  end
end
