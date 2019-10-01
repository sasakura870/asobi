class ArticlesController < ApplicationController
  before_action :store_location, only: %i[index new show edit drafts]
  before_action :filter_only_register, only: %i[drafts create]
  before_action :filter_only_current_user_article, only: %i[edit update destroy]
  before_action :filter_only_post, only: :show
  before_action :filter_drafts_over_10, only: :new

  layout 'article_show', only: :show

  def index
    @articles = Article.includes(thumbnail_attachment: :blob, user: :photo_attachment)
                       .posts.recent.page(params[:page])
  end

  def new
    @article = current_user.articles.new
  end

  def edit
    # @article ||= current_user.articles.find_by(id_digest: params[:id])
  end

  def show
    # @article ||= Article.find_by(id_digest: params[:id])
  end

  def drafts
    @articles = current_user.articles.drafts.recent
  end

  def favorites
    @article = Article.find_by(id_digest: params[:id])
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      flash[:success] = @article.posted ? '投稿しました！' : '下書きに保存しました'
      redirect_to article_path(@article)
    else
      flash.now[:danger] = '入力に不備があります'
      render :new
    end
  end

  def update
    # @article ||= current_user.articles.find_by(id_digest: params[:article][:id_digest])
    if @article.update(article_params)
      flash[:success] = @article.posted ? '投稿しました！' : '下書きに保存しました'
      redirect_to article_path(@article)
    else
      flash.now[:danger] = '入力に不備があります'
      render :edit
    end
  end

  def destroy
  end

  private

  def article_params
    result = params.require(:article).permit(:title,
                                             :overview,
                                             :thumbnail,
                                             :content,
                                             :posted)
    result[:posted] = (result[:posted] == '0')
    result
  end

  def filter_drafts_over_10
    if filter_only_register.nil?
      if current_user.articles.drafts.count >= 10
        flash[:warning] = '下書きが多すぎます'
        redirect_to drafts_path
      end
    end
  end

  def filter_only_post
    @article = Article.find_by(id_digest: params[:id])
    request_404 if @article.nil? || @article.draft?
  end

  def filter_only_current_user_article
    if filter_only_register.nil?
      @article = current_user.articles.find_by(id_digest: params[:id])
      if @article.nil?
        case action_name
        when 'edit' then request_404
        when 'update', 'destroy' then request_422
        end
      end
    end
  end
end
