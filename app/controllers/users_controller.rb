class UsersController < ApplicationController
  def index
  end

  def new
    render layout: '/layouts/sessions'
    @user = User.new
  end

  def show
  end

  def edit
  end
end
