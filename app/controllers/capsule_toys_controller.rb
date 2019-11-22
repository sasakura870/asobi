class CapsuleToysController < ApplicationController
  def index
    handler = CapsuleToys::IndexHandler.new.run
    @article = handler.model
    render :index, formats: :json, handlers: :jbuilder
  end
end
