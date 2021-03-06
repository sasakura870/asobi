class CreateArticleService < ApplicationService
  def initialize(user:, params:, tag_list:)
    @user = user
    @params = params
    @tag_list = tag_list
  end

  private

  attr_reader :user, :params, :tag_list

  def perform
    article = user.articles.build params
    article.link_tag tag_list
    if article.save
      article.create_id_digest
      service_succeeded model: article
    else
      service_failed message: '記事の作成に失敗しました', model: article
    end
  end
end
