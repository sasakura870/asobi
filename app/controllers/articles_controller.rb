class ArticlesController < ApplicationController
  before_action :filter_only_register, only: %i[create]
  before_action :filter_only_post, only: :show
  before_action :filter_drafts_over_10, only: :new

  layout 'article_show', only: :show

  # TODO いらない？
  # def index
  #   @articles = Article.includes(thumbnail_attachment: :blob, user: :photo_attachment)
  #                      .posts.recent.page(params[:page])
  # end

  def new
    @article = current_user.articles.new
  end

  def edit
    @article = current_user.articles.find_by(id_digest: params[:id])
    request_404 if @article.nil?
  end

  def show
    # @article ||= Article.find_by(id_digest: params[:id])
  end

  def favorites
    @article = Article.find_by(id_digest: params[:id])
  end

  def create
    @article = current_user.articles.new(article_params)
    if @article&.save
      if @article.published?
        flash[:success] = '投稿しました！'
        redirect_to @article
      elsif @article.draft?
        flash[:success] = '下書きに保存しました'
        redirect_to drafts_path
      end
    else
      flash.now[:error] = '入力に不備があります'
      render :new
    end
  end

  def update
    @article = current_user.articles.find_by(id_digest: params[:article][:id_digest])
    if @article&.update(article_params)
      if @article.published?
        flash[:success] = '投稿しました！'
        redirect_to @article
      elsif @article.draft?
        flash[:success] = '下書きに保存しました'
        redirect_to drafts_path
      end
    else
      flash.now[:error] = '入力に不備があります'
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
                                             :status)
    result[:status] = result[:status].to_sym
    result
  end

  def filter_drafts_over_10
    if filter_only_register.nil?
      if current_user.articles.draft.count >= 10
        flash[:warning] = '下書きが多すぎます'
        redirect_to drafts_path
      end
    end
  end

  def filter_only_post
    @article = Article.find_by(id_digest: params[:id])
    request_404 if @article.nil? || @article.draft?
  end
end
