class FavoritesController < ApplicationController
  before_action :filter_only_register

  def create
    service = CreateFavoriteService.new(
      user: current_user,
      article_id: params[:article_id])
    if service.call
      head :created
    else
      request_422
    end
  end

  def destroy
    @article = Article.find_by(id: params[:article_id])
    favorite = current_user.favorites.find_by(user_id: current_user.id, article_id: @article.id)
    if favorite&.destroy
      head :ok
    else
      request_422
    end
  end
end
