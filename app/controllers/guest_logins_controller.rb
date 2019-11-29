class GuestLoginsController < ApplicationController
  before_action :pass_only_logout

  def create
    GuestLogins::CreateHandler.new(session: session).run
    flash[:success] = 'ログインしました'
    redirect_back_or root_path
  end
end
