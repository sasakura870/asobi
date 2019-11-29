class AccountActivationsController < ApplicationController
  before_action :pass_only_temporary

  layout 'sessions'

  def index; end

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
