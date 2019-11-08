module Settings
  class RememberController < Base
    def create
      remember
      head :ok
    end

    def destroy
      forget
      head :ok
    end
  end
end
