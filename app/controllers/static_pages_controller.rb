class StaticPagesController < ApplicationController
  def home
    @articles = Article.page(params[:page])
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
