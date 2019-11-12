class CommentsController < ApplicationController
  before_action :filter_only_register

  def create
    handler = Comments::CreateHandler.new(
      user: current_user,
      article_id: comment_params[:article_id],
      content: comment_params[:content]
    )
    if handler.run
      flash[:success] = 'コメントを投稿しました'
      # TODO ajax化したい
      redirect_to Article.published.find_by(id: comment_params[:article_id])
    else
      request_422
    end
  end

  def destroy
    handler = Comments::DestroyHandler.new(
      user: current_user,
      comment_id: params[:id]
    )
    if handler.run
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
