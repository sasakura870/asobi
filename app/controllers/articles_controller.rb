class ArticlesController < ApplicationController
  before_action :logged_in_user, except: %i[index show]

  layout 'article_show', only: :show

  def index
    @articles = Article.where(posted: true).recent.page(params[:page])
  end

  def new
  end

  def edit
  end

  def show
    @article = Article.find_by(id: params[:id])
  end

  def create
  end

  def update
  end

  def destroy
  end
end
