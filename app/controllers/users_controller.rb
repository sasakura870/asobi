class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit]
  def index
    @users = User.page(params[:page])
  end

  def new
    @user = User.new
    render layout: '/layouts/sessions'
  end

  def show
    @user = User.find_by(name: params[:id])
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      flash[:success] = '登録に成功しました!'
      redirect_to user_path(@user.name)
    elsif
      flash.now[:danger] = '登録に失敗しました'
      render :new, layout: '/layouts/sessions'
    end
  end

  def update
    @user = User.find(params[:user][:id])
    if @user.update(user_update_params)
      flash[:success] = '設定を更新しました'
      redirect_to user_path(@user.name)
    else
      flash.now[:danger] = '設定の更新に失敗しました'
      render :edit
    end
  end

  private

  def user_create_params
    params.require(:user).permit(:name,
                                 :email,
                                 :introduction,
                                 :password,
                                 :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:introduction,
                                 :photo)
  end

  def logged_in_user
    redirect_to login_path unless logged_in?
  end
end
