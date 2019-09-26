module ActionFilter
  extend ActiveSupport::Concern

  included do
    def filter_only_register
      if logged_in? && !current_user.activated?
        flash[:warning] = '本登録が完了していません'
        redirect_to confirmation_user_path(current_user)
      elsif !logged_in?
        redirect_to login_path
      end
    end

    def filter_only_no_activation_users
      redirect_to root_path unless current_user&.activated?
    end

    def filter_only_logged_in_users
      redirect_to login_path unless logged_in?
    end

    def filter_only_guests
      redirect_to root_path if logged_in?
    end
  end
end