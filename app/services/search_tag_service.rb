class SearchTagService < ApplicationService
  def initialize(q:)
    @q = q
  end

  private

  attr_reader :q

  def perform
    if q.blank?
      service_failed message: '検索するキーワードを入力してください', model: Tag.none
      return
    end

    result = Tag.where('name iLIKE ?', "%#{q}%")
    service_succeeded model: result
  end
end
