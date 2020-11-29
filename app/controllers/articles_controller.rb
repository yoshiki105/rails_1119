class ArticlesController < ApplicationController
  before_action :login_required, except: %i[index show]

  # 記事一覧
  def index
    @articles = Article.order(released_at: :desc)
  end

  # 記事詳細
  def show
    @article = Article.find(params[:id])
  end
end
