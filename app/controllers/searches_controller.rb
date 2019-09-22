class SearchesController < ApplicationController
  def search
    @q = search_params[:q]
    @articles = Article
                  .includes(thumbnail_attachment: :blob, user: :photo_attachment)
                  .fair_copy.search_title(@q).recent.page(params[:page])
  end

  private

  def search_params
    params.permit(:q)
  end
end
