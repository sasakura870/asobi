module Settings
  class QuitController < Base
    layout 'sessions'

    def index; end

    def destroy
      input_data = update_params(:quit, :password)
      handler = Settings::Quit::DestroyHandler.new(
        user: current_user,
        password: input_data[:password],
        session: session,
        cookies: cookies
      )
      # TODO 失敗時のエラーメッセージが出ない
      flash[:error] = handler.fail_message unless handler.run
      render :index
    end
  end
end
