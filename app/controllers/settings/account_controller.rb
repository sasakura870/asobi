module Settings
  class AccountController < Base
    def index; end

    def update
      # TODO サービス層に移動
      input_data = update_params(:account, :email)
      if current_user&.update(input_data)
        UserMailer.email_resetting(current_user).deliver_now
        flash[:info] = 'メールを送信しました'
        redirect_to settings_account_index_path
      else
        flash.now[:error] = 'メールアドレスの変更に失敗しました'
        render :index
      end
    end
  end
end
