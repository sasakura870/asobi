class Settings::AccountController < Settings::Base
  def index

  end

  def update
    # TODO サービス層に移動
    input_data = update_params(:account, :email)
    if current_user&.update(input_data)
      # TODO メール送信
      # TODO 仮登録状態に変更
      flash[:info] = 'メールを送信しました'
      redirect_to settings_account_index_path
    else
      flash.now[:error] = 'メールアドレスの変更に失敗しました'
      render :index
    end
  end
end
