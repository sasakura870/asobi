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

  def request_404
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end

  def request_422
    render file: Rails.root.join('public/422.html'), status: 422, layout: false, content_type: 'text/html'
  end
end
