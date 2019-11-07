class TagsController < ApplicationController
  layout 'left_sidemenu'

  def show
    @tag = Tag.find_by(name: params[:id])
    request_404 if @tag.nil?
  end
end
