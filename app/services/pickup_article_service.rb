class PickupArticleService < ApplicationService
  class PickupArticleResult
    attr_reader :article, :user, :tag_list

    def initialize(article:, user:, tag_list:)
      @article = article
      @user = user
      @tag_list = tag_list
    end
  end

  def initialize; end

  private

  def perform
    pickup_id = Article.pluck(:id).sample
    article = Article.find(pickup_id)
    user = article.user
    tag_list = article.tags
    result = PickupArticleResult.new(
      article: article,
      user: user,
      tag_list: tag_list
    )
    service_succeeded model: result
  end
end
