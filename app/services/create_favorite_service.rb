class CreateFavoriteService < ApplicationService
  attr_reader :user, :article

  def initialize(user:, article:)
    @user = user
    @article = article
  end

  def call
    favorite = user.favorites.build(article_id: article.id)
    if favorite.save
      true
    else
      false
    end
  end
end