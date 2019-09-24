class FavoritesController < ApplicationController
  # TODO フィルターチェック
  # article_idが存在しない値だった場合は？

  before_action :filter_only_logged_in_users
  before_action :filter_only_other_users_article

  def create
    article = Article.find_by(id: params[:article_id])
    favorite = current_user.favorites.build(article_id: article.id)
    if favorite.save
      flash[:success] = 'いいねしました'
    else
      flash[:danger] = 'いいねに失敗しました'
    end
    redirect_to article_path(article)
  end

  def destroy
    article = Article.find_by(id: params[:article_id])
    favorite = Favorite.find_by(user_id: current_user.id, article_id: params[:article_id])
    if favorite.destroy
      flash[:success] = 'いいねを取り消しました'
    else
      flash[:danger] = 'いいねの取り消しに失敗しました'
    end
    redirect_to article_path(article)
  end

  private

  def filter_only_other_users_article
    if current_user.articles.exists?(id: params[:article_id])
      redirect_to root_path
    end
  end
end
