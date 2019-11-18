class CommentsController < ApplicationController
  before_action :filter_only_register

  def create
    handler = Comments::CreateHandler.new(
      user: current_user,
      article_id: comment_params[:article_id],
      content: comment_params[:content]
    ).run
    if handler.result
      flash[:success] = handler.message
      redirect_to handler.model
    else
      request_422
    end
  end

  def destroy
    handler = Comments::DestroyHandler.new(
      user: current_user,
      comment_id: params[:id]
    ).run
    if handler.result
      render status: :ok, json: { type: 'success', message: handler.message }
    else
      render status: :internal_server_error,
             json: { type: 'error', message: handler.message }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:article_id, :content)
  end
end
