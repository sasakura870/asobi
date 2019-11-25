class AccountActivationsController < ApplicationController
  before_action :filter_only_temporary

  layout 'sessions'

  def index
    @user = User.find_by!(name: params[:id])
  end

  def edit
    handler = AccountActivations::EditHandler.new(
      email: params[:email],
      activation_token: params[:id],
      session: session
    ).run
    if handler.result
      flash[:success] = '本登録が完了しました！'
    else
      flash[:error] = handler.message
    end
    redirect_to root_path
  end
end
