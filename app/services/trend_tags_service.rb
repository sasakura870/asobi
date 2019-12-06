class TrendTagsService < ApplicationService
  def initialize; end

  private

  def perform
    # tags = []
    # TagMap.group('tag_id').order(count: :desc).limit(10).each do |tag|
    #   tags << Tag.find(tag.key)
    # end
    tags = Tag.order(created_at: :desc).limit(10)
    service_succeeded model: tags
  end
end
