module Searches
  class IndexHandler < ApplicationHandler
    def initialize(q:)
      @q = q
    end

    private

    attr_reader :q

    def handle
      result = SearchQueryService.new(q: q).call
      handle_succeeded model: result.model
    end
  end
end
