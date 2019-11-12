module Settings
  class PasswordController < Base
    def index; end

    def update
      input_data = update_params(
        :password,
        :old_password,
        :password,
        :password_confirmation
      )
      handler = Settings::Password::UpdateHandler.new(
        user: current_user,
        old_password: input_data[:old_password],
        password: input_data[:password],
        password_confirmation: input_data[:password_confirmation]
      )
      if handler.run
        flash[:success] = 'パスワードを更新しました'
        redirect_to settings_password_index_path
      else
        flash.now[:error] = 'パスワードの更新に失敗しました'
        render :index
      end
    end
  end
end
