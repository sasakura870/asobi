class SearchesViewModel
  attr_reader :articles_count, :users_count, :tags_count, :show_data

  def initialize(articles_count:, users_count:, tags_count:, show_data:)
    @articles_count = articles_count
    @users_count = users_count
    @tags_count = tags_count
    @show_data = show_data
  end
end
