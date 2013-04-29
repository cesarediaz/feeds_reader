class ArticlesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @articles = Article.text_search(params[:query]).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def add_articles
    @channel = Channel.find(params[:channel])
    @starred_articles_ids = current_user.articles.map { |r| r.id }
    begin
      unless @channel.updated_recently?
        Article.update_from_feed(params[:url], params[:channel])
      end
      params[:page] = params[:page] ||= 1
      @articles = @channel.articles.page(params[:page])
    rescue
      @articles = @channel.articles.page(params[:page])
    end
    respond_to do |format|
      format.js
    end
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.page(params[:page])
    respond_to do |format|
      format.js
    end
  end

  def starred
    @id = params[:id]
    article = Article.find(params[:id])
    current_user.articles << article
    respond_to do |format|
      format.js
    end
  end

  def starred_list
    @articles = current_user.articles.page(params[:page])
    respond_to do |format|
      format.js
    end
  end

end
