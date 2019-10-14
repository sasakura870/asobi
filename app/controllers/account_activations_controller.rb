class AccountActivationsController < ApplicationController
  before_action :filter_only_temporary

  def edit
    user = User.find_by(email: params[:email])
    if user&.authenticate_activation(params[:id]) && user&.temporary?
      user.signup
      login user
      flash[:success] = '本登録が完了しました！'
      # redirect_to root_path
      redirect_back_or root_path
    else
      flash[:error] = '無効なURLです'
      redirect_to root_path
    end
  end
end
