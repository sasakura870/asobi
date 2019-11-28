class HomeController < ApplicationController
  before_action :filter_only_logged_in_users, only: :timeline

  def index
    handler = Home::IndexHandler.new.run
    @trend_articles = handler.model.articles
    @trend_users = handler.model.users
    @trend_tags = handler.model.tags
  end

  def timeline
    handler = Home::TimelineHandler.new(
      visitor: current_user,
      page: params[:page]
    ).run
    @feed_items  = handler.model.articles
    @trend_users = handler.model.users
    @trend_tags = handler.model.tags
  end
end
