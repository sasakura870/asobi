module Settings
  class ProfileController < Base
    def index; end

    def update
      input_data = update_params(:profile, :name, :nick_name, :photo, :introduction)
      if current_user&.update(input_data)
        flash[:success] = 'プロフィールを更新しました'
        redirect_to settings_profile_index_path
      else
        current_user.reload
        flash.now[:error] = 'プロフィールの更新に失敗しました'
        render :index
      end
    end
  end
end
