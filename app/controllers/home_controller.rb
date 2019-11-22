class HomeController < ApplicationController
  def index
    # TODO: viewModel検討する？
    @trend_articles = Article
                      .includes(:tags, user: { photo_attachment: :blob }, tag_maps: :tag)
                      .published
                      .recent
                      .take(12)
    @trend_users = User
                   .includes(photo_attachment: :blob)
                   .register
                   .order(id: :desc)
                   .take(6)
    @trend_tags = Tag.order(id: :desc).take(10)
  end
end
