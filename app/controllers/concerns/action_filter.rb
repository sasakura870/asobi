# TODO Policy層に移動したい
module ActionFilter
  extend ActiveSupport::Concern

  included do
    def filter_only_current_user(user)
      if logged_in? && current_user.id != user.id
        request_422
      elsif !logged_in?
        redirect_login_holding_request
      end
    end

    def filter_only_register
      if logged_in? && current_user.temporary?
        flash[:warning] = '本登録が完了していません'
        redirect_to confirmation_users_path
      elsif !logged_in?
        redirect_login_holding_request
      end
    end

    def filter_only_temporary
      if logged_in? && current_user.register?
        redirect_to user_path(current_user)
      elsif !logged_in?
        redirect_login_holding_request
      end
    end

    def filter_only_logged_in_users
      redirect_login_holding_request unless logged_in?
    end

    def filter_only_guests
      redirect_to user_path(current_user) if logged_in?
    end

    def store_location
      session[:return_to] = request.url if request.get?
    end

    private

    def redirect_login_holding_request
      store_location
      redirect_to login_path
    end
  end
end