module Settings
  class AccountController < Base
    before_action :filter_only_guest

    def index; end

    def update
      input_data = update_params(:account, :email)
      handler = Settings::Account::UpdateHandler.new(
        user: current_user,
        email: input_data[:email]
      )
      if handler.run
        flash[:info] = '認証用のメールを送信しました'
        redirect_to settings_account_index_path
      else
        flash.now[:error] = 'メールアドレスの変更に失敗しました'
        render :index
      end
    end
  end
end
