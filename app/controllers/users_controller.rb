class UsersController < ApplicationController
  before_action :filter_only_guests, only: %i[new create]
  before_action :filter_temporary_users_page, only: :show

  layout :switch_layout

  # # TODO いらない？
  # def index
  #   @users = User.includes(:photo_attachment).page(params[:page])
  # end

  def new
    @user = User.new
  end

  def show
    # @user = User.find_by(name: params[:id])
    @articles = @user.articles.recent.page(params[:page])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.account_activation(@user).deliver_now
      login @user
      flash[:info] = '本登録用のメールを送信しました'
      redirect_to account_activations_path
    else
      flash.now[:error] = '登録に失敗しました'
      render :new, layout: 'sessions'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

  def switch_layout
    case action_name
    when 'new' then 'sessions'
    when 'show' then 'left_sidebar'
    end
  end

  # 仮ユーザーのページは閲覧できない
  # 仮ユーザーが自分のページを閲覧する場合はaccount_activations#indexにリダイレクト
  def filter_temporary_users_page
    @user = User.find_by(name: params[:id])
    if @user&.temporary?
      if @user.id != current_user&.id
        request_404
      else
        redirect_to account_activations_path
      end
    end
  end
end
