class HomeController < ApplicationController
  def index
    # TODO: viewModel検討する？
    @daily_articles = Article
                      .includes(user: :photo_attachment)
                      .published
                      .recent
                      .take(10)
    @weekly_articles = Article
                       .includes(user: :photo_attachment)
                       .take(3)
    @recommended_articles = Article.includes(user: :photo_attachment)
                                   .recent.take(5)
  end
end
