module Settings
  class ProfileController < Base
    def index; end

    def update
      input_data = update_params :profile, :name, :nick_name, :introduction
      handler = Settings::Profile::UpdateHandler.new(
        user: current_user,
        params: input_data,
        photo: params[:profile][:photo]
      ).run
      if handler.result
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
