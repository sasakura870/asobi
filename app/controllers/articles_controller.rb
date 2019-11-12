class ArticlesController < ApplicationController
  before_action :filter_only_register, only: %i[create]
  before_action :filter_only_post, only: :show

  layout :switch_layout

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
    # TODO service
    @article = current_user.articles.new(article_params)
    new_tag_list = params[:article][:tags_list].split.uniq
    if @article&.save && new_tag_list.length <= 10
      # 入力されたタグを元に@articleとリンクさせる
      tag_list = []
      new_tag_list.each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        tag = Tag.create(name: tag_name) if tag.nil?
        tag_list << tag
      end
      @article.link_tag(tag_list)

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
    # TODO service
    @article = current_user.articles.find_by(id_digest: params[:article][:id_digest])
    new_tag_list = params[:article][:tags_list].split.uniq
    if @article&.update(article_params) && new_tag_list.length <= 10
      linked_tag_list = @article.tags.map(&:name)

      # @articleにリンクしていて、入力したタグに含まれていないタグ
      (linked_tag_list - new_tag_list).each do |tag_name|
        # リンク解除
        tag = Tag.find_by(name: tag_name)
        @article.unlink_tag(tag)
      end

      # 入力したタグに含まれていて、@articleがまだリンクしていないタグ
      tag_list = []
      (new_tag_list - linked_tag_list).each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        tag = Tag.create(name: tag_name) if tag.nil?
        tag_list << tag
      end
      @article.link_tag(tag_list)

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
    # TODO service
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

  def filter_only_post
    @article = Article.find_by(id_digest: params[:id])
    request_404 if @article.nil? || @article.draft?
  end

  def switch_layout
    case action_name
    when 'new', 'edit' then 'article_post'
    when 'show' then 'article_show'
    end
  end
end
