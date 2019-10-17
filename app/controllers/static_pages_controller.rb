class StaticPagesController < ApplicationController
  def home
    # TODO viewModel検討する？
    @daily_articles = Article
                        .includes(thumbnail_attachment: :blob, user: :photo_attachment)
                        .recent.take(3)
    @weekly_articles = Article
                        .includes(thumbnail_attachment: :blob, user: :photo_attachment)
                        .take(3)
    @recommended_articles = Article.includes(user: :photo_attachment)
                                   .recent.take(5)
  end

  def about
  end

  def help
  end

  def terms
  end

  def privacy
  end
end
