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
      ).run
      flash.now[:error] = handler.message unless handler.result
      render :index
    end
  end
end
