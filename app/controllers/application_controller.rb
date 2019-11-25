class ApplicationController < ActionController::Base
  include ActionFilter

  before_action :store_location, if: -> {
    request.get? && controller_name != 'sessions' && controller_name != 'capsule_toys'
  }

  helper_method :current_user

  protected

  # TODO: service層に処理を移動したい
  def current_user
    return @current_user unless @current_user.nil?

    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      user = User.find_by(id: cookies.signed[:user_id])
      if user&.authenticate_remember(cookies[:remember])
        session[:user_id] = user.id
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def request_404
    render file: Rails.root.join('public/404.html'), status: 404, layout: false, content_type: 'text/html'
  end

  private

  def store_location
    session[:return_to] = request.url
  end
end
