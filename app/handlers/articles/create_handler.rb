module Articles
  class CreateHandler < ApplicationHandler
    def initialize(user:, params:, tag_names:)
      @user = user
      @params = params
      @tag_names = tag_names
    end

    private

    attr_reader :user, :params, :tag_names

    def handle
      ActiveRecord::Base.transaction do
        tag_service_result = ListupTagService.new(tag_names: tag_names).call
        article_service_result = CreateArticleService.new(
          user: user,
          params: params,
          tag_list: tag_service_result.model
        ).call
        handle_succeeded model: article_service_result.model
      end
    end
  end
end
