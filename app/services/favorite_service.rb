class FavoriteService < ApplicationService
  def initialize(user:, article:)
    @user = user
    @article = article
  end

  private

  attr_reader :user, :article

  def perform
    service_failed message: 'いいねに失敗しました' if article.nil?

    favorite = user.favorites.build(article_id: article.id)
    favorite.save
  end
end
