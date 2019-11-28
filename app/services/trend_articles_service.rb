class TrendArticlesService < ApplicationService
  def initialize; end

  private

  def perform
    articles = Article
               .includes(
                 :rich_text_content,
                 :tags,
                 user: { photo_attachment: :blob },
                 tag_maps: :tag
               )
               .published
               .order(favorites_count: :desc)
               .take(12)
    service_succeeded model: articles
  end
end
