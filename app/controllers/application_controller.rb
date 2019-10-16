class ApplicationController < ActionController::Base
  include ActionFilter

  helper_method :current_user, :logged_in?

  protected

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

  def remember
    expire = 1.month.from_now.utc
    current_user.remember_me
    cookies.signed[:user_id] = { value: current_user.id, expires: expire }
    cookies[:remember] = { value: current_user.remember, expires: expire }
  end

  def forget
    current_user.forget_me
    cookies.delete(:user_id)
    cookies.delete(:remember)
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def request_404
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end

  def request_422
    render file: Rails.root.join('public/422.html'), status: 422, layout: false, content_type: 'text/html'
  end
end
