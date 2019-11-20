module Searches
  class Base < ApplicationController
    before_action :search_query

    private

    def search_query
      @q = params[:q]
      handler = Searches::IndexHandler.new(q: @q).run
      @search_models = handler.model
      flash.now[:error] = handler.message unless handler.result
    end
  end
end
