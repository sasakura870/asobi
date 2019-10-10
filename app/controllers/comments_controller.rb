class CommentsController < ApplicationController
  before_action :filter_only_register

  def create
    @article = Article.posts.find_by(id: comment_params[:article_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to @article
    else
      request_422
    end
  end

  def destroy
    comment = current_user.comments.find_by(id: params[:id])
    if comment&.destroy
      head :ok
    else
      request_422
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :content)
  end
end
