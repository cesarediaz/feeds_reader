class ArticlesController < ApplicationController

  MINUTES = 5
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
      unless updated_recently?(@channel)
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

  def updated_recently?(channel)
    hour = Time.now
    last_update = channel.updated_at
    hour.min - last_update.min < MINUTES ? true : false
  end

end
