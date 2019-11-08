class CreateFavoriteService < ApplicationService
  def initialize(user:, article_id:)
    @user = user
    @article_id = article_id
  end

  def call
    return false unless article

    favorite = user.favorites.build(article_id: article.id)
    if favorite.save
      true
    else
      false
    end
  end

  private

  attr_reader :user, :article_id

  def article
    @article ||= Article.find_by(id: article_id)
  end
end
