module Settings
  class RememberController < Base
    def create
      handler = Settings::Remember::CreateHandler.new(
        user: current_user,
        cookies: cookies
      )
      if handler.run
        render status: :ok, json: { type: 'success', message: 'ログイン状態を保持しました!' }
      else
        render status: :internal_server_error,
               json: { type: 'error', message: '永続ログインに失敗しました' }
      end
    end

    def destroy
      handler = Settings::Remember::DestroyHandler.new(
        user: current_user,
        cookies: cookies
      )
      if handler.run
        render status: :ok, json: { type: 'success', message: '永続ログインを解除しました!' }
      else
        render status: :internal_server_error,
               json: { type: 'error', message: '永続ログインの解除に失敗しました' }
      end
    end
  end
end
