module Searches
  class ArticlesController < Base
    def index
      @view_model = SearchesViewModel.new(
        articles_count: @search_models.articles.size,
        users_count: @search_models.users.size,
        tags_count: @search_models.tags.size,
        show_data: @search_models.articles.page(params[:page])
      )
    end
  end
end
