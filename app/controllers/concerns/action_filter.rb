module ActionFilter
  extend ActiveSupport::Concern

  included do
    def pass_only_register
      if logged_in? && current_user.temporary?
        flash[:warning] = '本登録が完了していません'
        redirect_to account_activations_path
      elsif !logged_in?
        redirect_to login_path
      end
    end

    def pass_only_temporary
      if logged_in? && current_user.register?
        redirect_to user_path current_user
      elsif !logged_in?
        redirect_to login_path
      end
    end

    def pass_only_logged_in_user
      redirect_to login_path unless logged_in?
    end

    def pass_only_logout
      redirect_to user_path(current_user) if logged_in?
    end
  end
end
