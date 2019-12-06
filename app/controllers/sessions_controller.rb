class SessionsController < ApplicationController
  before_action :pass_only_logged_in_user, only: :destroy
  before_action :pass_only_logout, only: %i[new create]

  def new; end

  def create
    handler = Sessions::CreateHandler.new(
      email: session_params[:email],
      password: session_params[:password],
      remember_check: session_params[:remember_check],
      session: session,
      cookies: cookies
    ).run
    if handler.result
      flash[:success] = 'ログインしました'
      redirect_back_or root_path
    else
      flash.now[:error] = 'メールアドレスまたはパスワードが違います'
      render :new
    end
  end

  def destroy
    handler = Sessions::DestroyHandler.new(
      user: current_user,
      session: session,
      cookies: cookies
    ).run
    flash_type = handler.result ? :success : :error
    flash[flash_type] = handler.message
    redirect_back_or root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password, :remember_check)
  end
end
