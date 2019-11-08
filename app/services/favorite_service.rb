class FavoriteService < ApplicationService
  def initialize(user:, article:)
    @user = user
    @article = article
  end

  private

  attr_reader :user, :article

  def perform
    return false if article.nil?

    favorite = user.favorites.build(article_id: article.id)
    favorite.save
  end
end
