class StaticPagesController < ApplicationController
  def home
    @daily_articles = Article.includes(:user, :thumbnail_attachment)
                             .recent.take(3)
    @weekly_articles = Article.includes(:user, :thumbnail_attachment)
                              .take(3)
    @recommended_articles = Article.includes(:user, :thumbnail_attachment)
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
