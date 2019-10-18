class Settings::PasswordController < Settings::Base
  def index; end

  def update
    # TODO ゆくゆくはサービス層に移動
    input_data = update_params(:password,
                               :old_password,
                               :password,
                               :password_confirmation)
    new_password_data = { password: input_data[:password],
                          password_confirmation: input_data[:password_confirmation] }
    if current_user&.authenticate(input_data[:old_password]) && current_user&.update(new_password_data)
      flash[:success] = 'パスワードを更新しました'
      redirect_to settings_password_index_path
    else
      flash.now[:error] = 'パスワードの更新に失敗しました'
      render :index
    end
  end
end
