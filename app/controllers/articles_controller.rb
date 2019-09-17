class ArticlesController < ApplicationController
  before_action :filter_only_logged_in_users, except: %i[index show]
  before_action :filter_drafts_over_10, only: :new

  layout 'article_show', only: :show

  def index
    @articles = Article.includes(:thumbnail_attachment, :user)
                       .fair_copy.recent.page(params[:page])
  end

  def new
    @article = current_user.articles.new
  end

  def edit
  end

  def show
    @article = Article.find_by(id_digest: params[:id])
  end

  def drafts
    @articles = current_user.articles.draft.recent
  end

  def create
    @article = current_user.articles.new(article_params)
    @article.posted = (article_params[:posted] == '0')

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

  def filter_drafts_over_10
    if current_user&.articles.draft.count >= 10
      flash[:warning] = '下書きが多すぎます'
      redirect_to drafts_path
    end
  end
end
