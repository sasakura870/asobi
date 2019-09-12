class ArticlesController < ApplicationController
  before_action :logged_in_user, except: %i[index show]

  layout 'article_show', only: :show

  def index
    @articles = Article.where(posted: true).recent.page(params[:page])
  end

  def new
    @article = current_user.articles.new
  end

  def edit
  end

  def show
    @article = Article.find_by(id_digest: params[:id])
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      flash[:success] = '投稿しました！'
      redirect_to article_path(@article)
    else
      flash.now[:danger] = '入力に不備があります'
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def article_params
    params.require(:article).permit(:title,
                                    :overview,
                                    :thumbnail,
                                    :content,
                                    :posted)
  end
end
