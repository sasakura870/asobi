class DraftsController < ApplicationController
  before_action :filter_only_register

  def index
    @articles = current_user.articles.drafts.recent
  end
end
