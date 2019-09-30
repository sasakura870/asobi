class CommentsController < ApplicationController
  before_action :filter_only_register

  def create
    @article = Article.posts.find_by(id: comment_params[:article_id])
    return request_422 if @article.nil?

    @comment = current_user.comments.new(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to @article
    else
      # flash.now[:danger] = 'コメントに失敗しました'
      # render @article
      request_422
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    return request_422 if @comment.nil? || current_user.comments.exclude?(@comment)

    @article = @comment.article
    if @comment.destroy
      flash[:success] = 'コメントを削除しました'
      redirect_to @article
    else
      # flash.now[:danger] = 'コメントの削除に失敗しました'
      # render @article
      request_422
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :content)
  end
end
