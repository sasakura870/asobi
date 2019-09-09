class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      # セッションを作成
      login user
      flash[:success] = 'ログインしました'
      redirect_to root_path
    elsif
      flash.now[:danger] = 'メールアドレスまたはパスワードが違います'
      render :new
    end
  end

  def destroy
    logout if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
