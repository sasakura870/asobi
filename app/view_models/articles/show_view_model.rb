module Articles
  class ShowViewModel
    def initialize(article:, visitor:)
      @article = article
      @visitor = visitor
    end

    private

    attr_reader :article, :visitor

    # article.id, article.fav_count, visitorAlreadyFav
    # author
  end
end
