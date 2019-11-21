class SearchQueryService < ApplicationService
  class SearchQueryResult
    attr_reader :articles, :users, :tags

    def initialize(articles:, users:, tags:)
      @articles = articles
      @users = users
      @tags = tags
    end
  end

  def initialize(q:)
    @q = q
  end

  private

  attr_reader :q

  def perform
    if q.blank?
      result = SearchQueryResult.new(
        articles: Article.none,
        users: User.none,
        tags: Tag.none
      )
      service_failed message: '検索するキーワードを入力してください', model: result
      return
    end

    users = User.includes(photo_attachment: :blob)
                .where('name iLIKE ? OR nick_name iLIKE ?', "%#{q}%", "%#{q}%")
    tags = Tag.where('name iLIKE ?', "%#{q}%")
    articles = Article.includes(:tags, user: { photo_attachment: :blob }, tag_maps: :tag)
                      .published
                      .where('title iLIKE ? OR overview iLIKE ?', "%#{q}%", "%#{q}%")
    result = SearchQueryResult.new(
      articles: articles,
      users: users,
      tags: tags
    )
    service_succeeded model: result
  end
end
