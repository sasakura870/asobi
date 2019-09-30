class UsersController < ApplicationController
  before_action :store_location, only: %i[index new show edit]
  before_action :filter_only_guests, only: %i[new create]
  before_action :filter_only_logged_in_users, only: %i[edit]
  before_action :filter_only_temporary, only: :confirmation
  before_action :filter_temporary_users_page, only: :show
  before_action -> {
    user = User.find_by(name: params[:id])
    filter_only_current_user(user)
    }, only: %i[update destroy]

  layout :switch_layout

  def index
    @users = User.includes(:photo_attachment).page(params[:page])
  end

  def new
    @user = User.new
  end

  def show
    # @user = User.find_by(name: params[:id])
    @articles = @user.articles.includes(thumbnail_attachment: :blob)
                              .recent.page(params[:page])
  end

  def edit
    @user = current_user
  end

  # 仮登録時のアクション。もっといい名前がある？
  def confirmation
    @user = User.find_by(name: params[:id])
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = '本登録用のメールを送信しました'
      redirect_to confirmation_users_path
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new, layout: 'sessions'
    end
  end

  def update
    @user = User.find(params[:user][:id])
    if @user.update(user_update_params)
      flash[:success] = '設定を更新しました'
      redirect_to settings_path
    else
      flash.now[:danger] = '設定の更新に失敗しました'
      render :edit
    end
  end

  def destroy

  end

  private

  def user_create_params
    params.require(:user).permit(:name,
                                 :email,
                                 :introduction,
                                 :password,
                                 :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name,
                                 :email,
                                 :introduction,
                                 :photo)
  end

  def switch_layout
    case action_name
    when 'new', 'confirmation' then 'sessions'
    when 'show', 'edit' then 'left_sidemenu'
    end
  end

  # 仮ユーザーのページは閲覧できない
  # 仮ユーザーが自分のページを閲覧する場合のみ許可
  def filter_temporary_users_page
    @user = User.find_by(name: params[:id])
    if @user&.temporary?
      unless @user.id == current_user&.id
        # render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
        request_404
      end
    end
  end
end
