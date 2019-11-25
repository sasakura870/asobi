class TagsController < ApplicationController
  layout 'left_sidebar'

  def show
    @tag = Tag.find_by! name: params[:id]
    @articles = @tag.articles
                    .includes(
                      :rich_text_content,
                      :tags,
                      user: { photo_attachment: :blob },
                      tag_maps: :tag
                    )
                    .published
                    .recent
                    .page params[:page]
    # request_404 if @tag.nil?
  end
end
