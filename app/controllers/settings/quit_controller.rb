class Settings::QuitController < Settings::Base
  layout 'sessions'

  def index; end

  def destroy
    input_data = update_params(:quit, :password)
    if current_user&.authenticate input_data[:password]
      if current_user&.destroy
        cookies.delete(:user_id)
        cookies.delete(:remember)
        logout
      else
        flash[:error] = '退会に失敗しました。時間を空けてもう一度お試しください'
      end
    else
      flash[:error] = 'パスワードが正しくありません'
    end
    render :index
  end
end
