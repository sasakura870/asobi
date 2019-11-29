class FavoritesController < ApplicationController
  before_action :pass_only_allowed

  def create
    handler = Favorites::CreateHandler.new(
      user: current_user,
      article_id: params[:article_id]
    ).run
    if handler.result
      render status: :ok, json: { type: 'success', message: 'いいねしました!' }
    else
      render status: :internal_server_error,
             json: { type: 'error', message: 'いいねに失敗しました' }
    end
  end

  def destroy
    handler = Favorites::DestroyHandler.new(
      user: current_user,
      article_id: params[:article_id]
    ).run
    if handler.result
      render status: :ok, json: { type: 'success', message: 'いいねを解除しました!' }
    else
      render status: :internal_server_error,
             json: { type: 'error', message: 'いいねの解除に失敗しました' }
    end
  end
end
