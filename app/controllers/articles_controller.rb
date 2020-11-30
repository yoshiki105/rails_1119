class ArticlesController < ApplicationController
  before_action :login_required, except: %i[index show]

  # 記事一覧
  def index
    @articles = Article.order(released_at: :desc)

    @articles = @articles.open_to_the_public unless current_member

    unless current_member&.administrator?
      @articles = @articles.visible
    end
  end

  # 記事詳細
  def show
    articles = Article.all

    articles = articles.open_to_the_public unless current_member

    unless current_member&.administrator?
      articles = articles.visible
    end

    @article = articles.find(params[:id])
  end

  # 新規登録フォーム
  def new
    @article = Article.new
  end

  # 編集フォーム
  def edit
    @article = Article.find(params[:id])
  end

  # 新規作成
  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to @article, notice: 'ニュース記事を登録しました。'
    else
      render 'new'
    end
  end

  # 更新
  def update
    @article = Article.find(params[:id])
    @article.assign_attributes(params[:article])
    if @article.save
      redirect_to @article, notice: 'ニュース記事を更新しました。'
    else
      render 'edit'
    end
  end

  # 終了
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to :articles, notice: "記事「#{@article.title}」を削除しました。"
  end

end
