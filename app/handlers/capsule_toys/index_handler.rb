module CapsuleToys
  class IndexHandler < ApplicationHandler
    def initialize; end

    private

    def handle
      result = PickupArticleService.new.call
      handle_succeeded model: result.model
    end
  end
end
