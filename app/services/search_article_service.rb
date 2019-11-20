class SearchArticleService < ApplicationService
  def initialize(q:)
    @q = q
  end

  private

  attr_reader :q

  def perform
    if q.nil?
      service_failed message: '検索するキーワードを入力してください'
      return
    end

    # キーワードがタイトル、概要、タグのいづれかに含まれている記事を探し出す
  end
end
