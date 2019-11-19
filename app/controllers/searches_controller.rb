class SearchesController < ApplicationController
  def index
    @q = search_params[:q]
    @articles = Article
                .includes(user: :photo_attachment)
                .published.search_title(@q).recent.page(params[:page])
  end

  private

  def search_params
    params.permit(:q)
  end
end
