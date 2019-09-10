class ArticlesController < ApplicationController
  before_action :logged_in_user, except: %i[index show]

  def index
    @articles = Article.where(posted: true).page(params[:page])
  end

  def new
  end

  def edit
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end
end
