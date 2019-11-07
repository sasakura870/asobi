class TagsController < ApplicationController
  layout 'left_sidebar'

  def show
    @tag = Tag.find_by(name: params[:id])
    @articles = @tag.articles.published.recent.page(params[:page])
    request_404 if @tag.nil?
  end
end
