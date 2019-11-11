class UnfavoriteService < ApplicationService
  def initialize(user:, article:)
    @user = user
    @article = article
  end

  private

  attr_reader :user, :article

  def perform
    favorite = user.favorites.find_by(article_id: article.id)
    favorite&.destroy
  end
end
