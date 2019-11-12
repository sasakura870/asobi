class AccountActivationsController < ApplicationController
  before_action :filter_only_temporary

  layout 'sessions'

  def index
    @user = User.find_by(name: params[:id])
  end

  def edit
    handler = AccountActivations::EditHandler.new(
      email: params[:email],
      activation_token: params[:id],
      session: session
    )
    if handler.run
      flash[:success] = '本登録が完了しました！'
    else
      flash[:error] = '無効なURLです'
    end
    redirect_to root_path
  end
end
