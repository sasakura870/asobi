class FavoriteService < ApplicationService
  def initialize(user:, article:)
    @user = user
    @article = article
  end

  private

  attr_reader :user, :article

  def perform
    return false unless article

    favorite = user.favorites.build(article: article.id)
    favorite.save
  end

  # def article
  #   @article ||= Article.find_by(id: article)
  # end
end
