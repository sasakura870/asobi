class UsersController < ApplicationController
  before_action :filter_only_guests, only: %i[new create]
  before_action :filter_temporary_users_page, only: %i[show favorites followings followers]

  layout :switch_layout

  def new
    @user = User.new
  end

  def show
    @articles = @user.articles
                     .includes(:rich_text_content, :tags, tag_maps: :tag)
                     .published
                     .recent
                     .page params[:page]
  end

  def favorites
    @articles = @user.favorite_articles
                     .includes(
                       :rich_text_content,
                       :tags,
                       user: { photo_attachment: :blob },
                       tag_maps: :tag
                      )
                     .published
                     .recent
                     .page params[:page]
  end

  def followings
    @followings = @user.followings
                       .includes(photo_attachment: :blob)
                       .page params[:page]
  end

  def followers
    @followers = @user.followers
                      .includes(photo_attachment: :blob)
                      .page params[:page]
  end

  def create
    handler = Users::CreateHandler.new(
      params: user_params,
      accept: params[:user][:accept],
      session: session
    ).run
    if handler.result
      flash[:info] = '本登録用のメールを送信しました'
      redirect_to account_activations_path
    else
      @user = handler.model
      flash.now[:error] = handler.message
      render :new, layout: 'sessions'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def switch_layout
    case action_name
    when 'new' then 'sessions'
    when 'show', 'favorites', 'followings', 'followers' then 'left_sidebar'
    end
  end

  # 仮ユーザーのページは閲覧できない
  # 仮ユーザーが自分のページを閲覧する場合はaccount_activations#indexにリダイレクト
  def filter_temporary_users_page
    if current_user&.temporary? && current_user&.name == params[:id]
      redirect_to account_activations_path
    else
      @user = User.register.find_by! name: params[:id]
    end
    # @user = User.find_by(name: params[:id])
    # if @user&.temporary?
    #   if @user.id != current_user&.id
    #     request_404
    #   else
    #     redirect_to account_activations_path
    #   end
    # end
  end
end
