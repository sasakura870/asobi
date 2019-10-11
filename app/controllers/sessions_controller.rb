class SessionsController < ApplicationController
  before_action :filter_only_logged_in_users, only: :destroy
  before_action :filter_only_guests, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      # セッションを作成
      login user
      # チェックが付いていればログイン状態を保持する
      session_params[:remember_check] == '1' ? remember : forget
      flash[:success] = 'ログインしました' * 20
      flash[:warning] = 'ログインに成功しました'
      flash[:info] = "ログイン情報 : #{current_user.name}"
      redirect_back_or root_path
    else
      flash.now[:danger] = 'メールアドレスまたはパスワードが違います'
      render :new
    end
  end

  def destroy
    forget
    logout
    flash[:success] = 'ログアウトしました'
    flash[:warning] = 'ログアウトに成功しました'
    flash[:info] = 'ログアウト情報'
    redirect_back_or root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_check)
  end

  def remember
    expire = 1.month.from_now.utc
    current_user.remember_me
    cookies.signed[:user_id] = { value: current_user.id, expires: expire }
    cookies[:remember] = { value: current_user.remember, expires: expire }
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def forget
    current_user.forget_me
    cookies.delete(:user_id)
    cookies.delete(:remember)
  end
end
