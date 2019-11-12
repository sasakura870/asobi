class CommentsController < ApplicationController
  before_action :filter_only_register

  def create
    # TODO service
    @article = Article.published.find_by(id: comment_params[:article_id])
    @comment = current_user.comments.new(comment_params)
    # comment = current_user.comments.new(article_id: params[:article_id],
    #                                     content: params[:content])
    if @comment.save
      flash[:success] = 'コメントを投稿しました'
      redirect_to @article
      # head :created
    else
      request_422
    end
  end

  def destroy
    # TODO service
    comment = current_user.comments.find_by(id: params[:id])
    if comment&.destroy
      render json: { type: 'success', message: 'コメントを削除しました' }
    else
      request_422
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :content)
  end
end
