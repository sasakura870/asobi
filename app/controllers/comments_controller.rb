class CommentsController < ApplicationController
  before_action :filter_only_logged_in_users

  def create
    @article = Article.find_by(id: comment_params[:article_id])
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to @article
    else
      flash.now[:danger] = 'コメントに失敗しました'
      render @article
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @article = @comment.article

    if @comment.destroy
      flash[:success] = 'コメントを削除しました'
      redirect_to @article
    else
      flash.now[:danger] = 'コメントの削除に失敗しました'
      render @article
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :content)
  end
end