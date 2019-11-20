module Searches
  class Base < ApplicationController
    before_action :set_query

    private

    def set_query
      @q = params[:q]
    end
  end
end
