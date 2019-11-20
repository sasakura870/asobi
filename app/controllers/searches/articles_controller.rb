module Searches
  class ArticlesController < Base
    def index
      @q = searches_query
      # @articles = Article
      #             .includes(user: :photo_attachment)
      #             .published.search_title(@q).recent.page(params[:page])
    end
  end
end
