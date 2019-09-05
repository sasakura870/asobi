class UsersController < ApplicationController
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
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = '登録に成功しました!'
      redirect_to user_path(@user.name)
    elsif
      flash.now[:danger] = '登録に失敗しました'
      render :new, layout: '/layouts/sessions'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :introduction,
                                 :password,
                                 :password_confirmation)
  end
end
