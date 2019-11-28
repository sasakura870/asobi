class HomeController < ApplicationController
  def index
    # TODO: viewModel検討する？
    @trend_articles = Article
                      .includes(
                        :rich_text_content,
                        :tags,
                        user: { photo_attachment: :blob },
                        tag_maps: :tag
                      )
                      .published
                      .order(favorites_count: :desc)
                      .take(12)
    @trend_users = User
                   .includes(photo_attachment: :blob)
                   .register
                   .take(6)
    @trend_tags = Tag.order(id: :desc).take(10)

    if logged_in?
      @feed_items = Article
                    .joins(:tag_maps)
                    .where(
                      'user_id IN (:followings) OR tag_id IN (:tags)',
                      followings: current_user.following_ids,
                      tags: current_user.tag_ids
                    )
                    .distinct
                    .order(created_at: :desc)
                    .page(params[:page])
      # @timeline_items = []
      # @feed_items.each do |item|
      #   timeline_items << {
      #     user: {
      #       display_name: item.user.nick_name.nil? ? item.user.nick_name : "@#{item.user.name}",
      #       name: item.user.name
      #     }
      #   }
      # end
    end
  end

  def update
    @feed_items = Article
                    .joins(:tag_maps)
                    .where(
                      'user_id IN (:followings) OR tag_id IN (:tags)',
                      followings: current_user.following_ids,
                      tags: current_user.tag_ids
                    )
                    .distinct
                    .order(created_at: :desc)
                    .page(params[:page])
    @timeline_items = []
    @feed_items.each do |item|
      timeline_items << {
        user: {
          display_name: item.user.nick_name.nil? ? item.user.nick_name : "@#{item.user.name}",
          name: item.user.name
        }
      }
    end
  end
end
