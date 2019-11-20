module Searches
  class IndexHandler < ApplicationHandler
    def initialize(q:, action:)
      @q = q
      @action = action
    end

    private

    attr_reader :q, :action

    def handle
      result = SearchTagService.new(q: q).call
      handle_succeeded model: result.model
    end
  end
end
