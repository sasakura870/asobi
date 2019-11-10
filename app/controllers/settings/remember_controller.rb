module Settings
  class RememberController < Base
    def create
      handle = Settings::Remember::CreateHandler.new(
        user: current_user,
        cookies: cookies
      )
      if handle.run
        head :ok
      else
        request_422
      end
    end

    def destroy
      forget
      head :ok
    end
  end
end
