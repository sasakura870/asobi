class UsersController < ApplicationController
  before_action :filter_only_logged_in_users, only: %i[edit update destroy]

  layout :switch_layout

  def index
    @users = User.page(params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(name: params[:id])
    @articles = @user.articles.includes(:thumbnail_attachment)
                              .recent.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_create_params)

    if @user.save
      flash[:success] = '登録に成功しました!'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new, layout: 'sessions'
    end
  end

  def update
    @user = User.find(params[:user][:id])
    if @user.update(user_update_params)
      flash[:success] = '設定を更新しました'
      redirect_to user_path(@user)
    else
      flash.now[:danger] = '設定の更新に失敗しました'
      render :edit
    end
  end

  def destroy

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
    params.require(:user).permit(:name,
                                 :email,
                                 :introduction,
                                 :photo)
  end

  def switch_layout
    case action_name
    when 'new' then 'sessions'
    when 'show', 'edit' then 'left_sidemenu'
    end
  end
end
