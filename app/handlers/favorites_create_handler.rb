# module Favorites
# end
class FavoritesCreateHandler < ApplicationServiceHandler
  def initialize(user:, article_id:)
    @user = user
    @article_id = article_id
  end

  private

  attr_reader :user, :article_id

  def article
    @article ||= Article.find_by(id: article_id)
  end

  def handle
    FavoriteService.new(user: user, article: article).call
  end
end