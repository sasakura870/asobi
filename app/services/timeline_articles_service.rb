class TimelineArticlesService < ApplicationService
  def initialize(visitor:, page:)
    @visitor = visitor
    @page = page
  end

  private

  attr_reader :visitor, :page

  def perform
    timeline_items = Article
                     .includes(
                       :rich_text_content,
                       :tags,
                       user: { photo_attachment: :blob },
                       tag_maps: :tag
                     )
                     .joins(:tag_maps)
                     .where(
                       'user_id IN (:followings) OR tag_id IN (:tags)',
                       followings: visitor.following_ids,
                       tags: visitor.tag_ids
                     )
                     .distinct
                     .order(created_at: :desc)
                     .page(page)
    service_succeeded model: timeline_items
  end
end
