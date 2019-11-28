class HomeController < ApplicationController
  before_action :filter_only_logged_in_users, only: :timeline

  def index
    # # TODO: viewModel検討する？
    # @trend_articles = Article
    #                   .includes(
    #                     :rich_text_content,
    #                     :tags,
    #                     user: { photo_attachment: :blob },
    #                     tag_maps: :tag
    #                   )
    #                   .published
    #                   .order(favorites_count: :desc)
    #                   .take(12)
    # @trend_users = User
    #                .includes(photo_attachment: :blob)
    #                .register
    #                .take(6)
    # @trend_tags = Tag.order(id: :desc).take(10)
    handler = Home::IndexHandler.new.run
    @trend_articles = handler.model.articles
    @trend_users = handler.model.users
    @trend_tags = handler.model.tags
  end

  def timeline
    # @trend_users = User
    #                .includes(photo_attachment: :blob)
    #                .register
    #                .take(6)
    # @trend_tags = Tag.order(id: :desc).take(10)

    # @feed_items = Article
    #                 .joins(:tag_maps)
    #                 .where(
    #                   'user_id IN (:followings) OR tag_id IN (:tags)',
    #                   followings: current_user.following_ids,
    #                   tags: current_user.tag_ids
    #                 )
    #                 .distinct
    #                 .order(created_at: :desc)
    #                 .page(params[:page])
    handler = Home::TimelineHandler.new(
      visitor: current_user,
      page: params[:page]
    ).run
    @feed_items  = handler.model.articles
    @trend_users = handler.model.users
    @trend_tags = handler.model.tags
  end
end
