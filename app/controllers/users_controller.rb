class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
    render layout: '/layouts/sessions'
  end

  def show
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = '登録に成功しました!'
      redirect_to root_path
    elsif
      flash.now[:danger] = 'ユーザー名またはパスワードが違います'
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
