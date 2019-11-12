module Settings
  class RememberController < Base
    def create
      handler = Settings::Remember::CreateHandler.new(
        user: current_user,
        cookies: cookies
      )
      if handler.run
        head :ok
      else
        request_422
      end
    end

    def destroy
      handler = Settings::Remember::DestroyHandler.new(
        user: current_user,
        cookies: cookies
      )
      if handler.run
        head :ok
      else
        request_422
      end
    end
  end
end
