class Settings::RememberController < Settings::Base
  def create
    remember
    head :ok
  end

  def destroy
    forget
    head :ok
  end
end
