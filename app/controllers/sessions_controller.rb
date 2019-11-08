# TODO create, destroyのサービス層の導入
class SessionsController < ApplicationController
  before_action :filter_only_logged_in_users, only: :destroy
  before_action :filter_only_guests, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    handler = Sessions::CreateHandler.new(
      email: session_params[:email],
      password: session_params[:password],
      remember_check: session_params[:remember_check],
      session: session,
      cookies: cookies
    )
    if handler.run
      flash[:success] = 'ログインしました'
      redirect_back_or root_path
    else
      flash.now[:error] = 'メールアドレスまたはパスワードが違います'
      render :new
    end
  end

  def destroy
    forget
    logout
    flash[:success] = 'ログアウトしました'
    redirect_back_or root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_check)
  end
end
