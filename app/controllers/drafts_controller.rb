class DraftsController < ApplicationController
  before_action :filter_only_register

  def index
    @drafts = current_user.articles.draft.recent
  end

  def destroy
    draft = current_user.articles.draft.find_by(id: params[:id])
    if draft&.destroy
      render json: { type: 'success', message: '下書きを削除しました' }
    else
      request_422
    end
  end
end
