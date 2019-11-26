module Articles
  class UpdateHandler < ApplicationHandler
    def initialize(user:, id_digest:, params:, tag_names:)
      @user = user
      @id_digest = id_digest
      @params = params
      @tag_names = tag_names
    end

    private

    attr_reader :user, :id_digest, :params, :tag_names

    def handle
      ActiveRecord::Base.transaction do
        tag_service_result = ListupTagService.new(
          article: article,
          tag_names: tag_names
        ).call
        update_result = UpdateArticleService.new(
          article: article,
          params: params,
          tag_list: tag_service_result.model
        ).call
        handle_succeeded message: update_result.message, model: update_result.model
      end
    end

    def article
      @article ||= user.articles.find_by! id_digest: id_digest
    end
  end
end
