module Searches
  class UsersController < Base
    def index
      handler = Searches::IndexHandler.new(
        q: @q,
        action: :users
      ).run
      @result = handler.model.page params[:page]
      flash.now[:error] = handler.message unless handler.result
    end
  end
end
