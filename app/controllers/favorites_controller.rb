class FavoritesController < ApplicationController
  # TODO フィルタとvalidationの役割が被っている？
  before_action -> { filter_only_register || filter_only_other_users_article }
  # before_action :filter_only_register

  def create
    favorite = current_user.favorites.build(article_id: @article.id)
    if favorite.save
      flash[:success] = 'いいねしました'
      redirect_to article_path(@article)
    else
      request_422
    end
  end

  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, article_id: @article.id)
    if favorite&.destroy
      flash[:success] = 'いいねを取り消しました'
      redirect_to article_path(@article)
    else
      # flash[:danger] = 'いいねの取り消しに失敗しました'
      request_422
    end
  end

  private

  def filter_only_other_users_article
    @article = Article.find_by(id: params[:article_id])
    request_422 if @article.nil? || current_user.articles.include?(@article)
  end
end
