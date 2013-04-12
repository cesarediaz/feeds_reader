class ArticlesController < ApplicationController
  def add_articles
    @channel = Channel.find(params[:channel])
    @starred_articles_ids = current_user.articles.map { |r| r.id }
    begin
      params[:page] = params[:page] ||= 1
      Article.update_from_feed(params[:link], params[:channel])
      channel = Channel.find(params[:channel])
      @articles = channel.articles.page(params[:page])
      respond_to do |format|
        format.js
      end
    rescue
      channel = Channel.find(params[:channel])
      @articles = channel.articles.page(params[:page])
      respond_to do |format|
        format.js
      end
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
