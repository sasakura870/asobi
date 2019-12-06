class ArticlesController < ApplicationController
  before_action :pass_only_allowed, except: %i[show favorite]

  layout :switch_layout

  def new
    @article = current_user.articles.new
  end

  def edit
    @article = current_user.articles.find_by!(id_digest: params[:id])
    # request_404 if @article.nil?
  end

  def show
    @article = Article.published.find_by!(id_digest: params[:id])
    @favorite_users = @article.favorite_users
                              .includes(photo_attachment: :blob)
                              .limit 3
    @comments = @article.comments.includes user: { photo_attachment: :blob }
  end

  def favorite
    @article = Article.find_by!(id_digest: params[:id])
    @users = @article.favorite_users
                     .includes(photo_attachment: :blob)
                     .page(params[:page])
                     .per(24)
  end

  def create
    handler = Articles::CreateHandler.new(
      user: current_user,
      params: article_params,
      tag_names: params[:article][:tag]
    ).run
    @article = handler.model
    if handler.result
      if @article.published?
        flash[:success] = '投稿しました!'
        redirect_to @article
      elsif @article.draft?
        flash[:success] = '下書きに保存しました'
        redirect_to drafts_path
      end
    else
      flash.now[:error] = '入力に不備があります'
      render :new, layout: 'article_post'
    end
  end

  def update
    handler = Articles::UpdateHandler.new(
      user: current_user,
      id_digest: params[:article][:id_digest],
      params: article_params,
      tag_names: params[:article][:tag]
    ).run
    @article = handler.model
    if handler.result
      if @article.published?
        flash[:success] = '投稿しました！'
        redirect_to @article
      elsif @article.draft?
        flash[:success] = '下書きに保存しました'
        redirect_to drafts_path
      end
    else
      flash.now[:error] = handler.message
      render :edit, layout: 'article_post'
    end
  end

  def destroy
    handler = Articles::DestroyHandler.new(
      user: current_user,
      article_id_digest: params[:id]
    )
    if handler.run
      flash[:success] = '記事を削除しました'
      redirect_to current_user
    else
      @article = handler.fail_model
      flash[:success] = '記事の削除に失敗しました'
      render :show
    end
  end

  private

  def article_params
    result = params.require(:article).permit(
      :title,
      :overview,
      :content,
      :status
    )
    result[:status] = result[:status].to_sym
    result
  end

  def switch_layout
    case action_name
    when 'new', 'edit' then 'article_post'
    when 'show' then 'article_show'
    when 'favorite' then 'no_sidebar'
    end
  end
end
