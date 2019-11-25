class CapsuleToysController < ApplicationController
  def index
    handler = CapsuleToys::IndexHandler.new.run
    @article = handler.model.article
    @user = handler.model.user
    @tags = handler.model.tag_list
    render :index, formats: :json, handlers: :jbuilder
  end
end
