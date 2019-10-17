class AccountActivationsController < ApplicationController
  before_action :filter_only_temporary

  layout 'sessions'

  def index
    @user = User.find_by(name: params[:id])
  end

  def edit
    # TODO service層に移動
    user = User.find_by(email: params[:email])
    if user&.authenticate_activation(params[:id]) && user&.temporary? && !user&.activation_mail_expired?
      user.signup
      login user
      flash[:success] = '本登録が完了しました！'
    else
      flash[:error] = '無効なURLです'
    end
    redirect_to root_path
  end
end
