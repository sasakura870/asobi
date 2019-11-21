class HomeController < ApplicationController
  def index
    # TODO: viewModel検討する？
    @trend_articles = Article
                      .includes(user: :photo_attachment)
                      .published
                      .recent
                      .take(12)
    @trend_users = User.register.order(id: :desc).take(6)
    @trend_tags = Tag.order(id: :desc).take(10)
  end
end
