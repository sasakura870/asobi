class SearchUserService < ApplicationService
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

    result = User
             .includes(photo_attachment: :blob)
             .where('name iLIKE ? OR nick_name iLIKE ?', "%#{q}%", "%#{q}%")
    service_succeeded model: result
  end
end
