class DraftsController < ApplicationController
  before_action :filter_only_register
  layout 'no_sidebar'

  def index
    @drafts = current_user.articles.draft.recent.page params[:page]
  end

  def destroy
    handler = Drafts::DestroyHandler.new(
      user: current_user,
      article_id: params[:id]
    ).run
    if handler.result
      render json: { type: 'success', message: '下書きを削除しました' }
    else
      # request_422
      render status: :internal_server_error,
             json: { type: 'error', message: '下書きの削除に失敗しました' }
    end
  end
end
