class UpdateArticleService < ApplicationService
  def initialize(article:, params:, tag_list:)
    @article = article
    @params = params
    @tag_list = tag_list
  end

  private

  attr_reader :article, :params, :tag_list

  def perform
    if article.nil?
      service_failed message: '記事が見つかりませんでした'
      return
    end

    linked_tag_list = article.tags
    (linked_tag_list - tag_list).each do |tag|
      article.unlink_tag tag
    end

    (tag_list - linked_tag_list).each do |tag|
      article.link_tag tag
    end

    if article.update params
      service_succeeded message: '記事を編集しました!', model: article
    else
      service_failed message: '記事の編集に失敗しました', model: article
    end
  end
end
