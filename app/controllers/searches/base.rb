module Searches
  class Base < ApplicationController
    private

    def searches_query
      params[:q]
    end
  end
end
