class FavoritesController < ApplicationController
  before_action :filter_only_register

  def create
    handler = Favorites::CreateHandler.new(
      user: current_user,
      article_id: params[:article_id]
    )
    if handler.run
      head :created
    else
      request_422
    end
  end

  def destroy
    handler = Favorites::DestroyHandler.new(
      user: current_user,
      article_id: params[:article_id]
    )
    if handler.run
      head :ok
    else
      request_422
    end
  end
end
