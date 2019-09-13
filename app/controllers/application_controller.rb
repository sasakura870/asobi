class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  # private

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user&.authenticate_remember(cookies[:remember])
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def filter_only_logged_in_users
    redirect_to login_path unless logged_in?
  end
end
