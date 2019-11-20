module Searches
  class IndexHandler < ApplicationHandler
    def initialize(q:, action:)
      @q = q
      @action = action
    end

    private

    attr_reader :q, :action

    def handle
      case action
      when :articles

      when :users
        result = SearchUserService.new(q: q).call
      when :tags
        result = SearchTagService.new(q: q).call
      else
        raise NotImplementedError "searches#{action}は存在しません"
      end
      handle_succeeded model: result.model
    end
  end
end
