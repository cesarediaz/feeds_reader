class ArticlesController < ApplicationController
  def add_articles
    @channel = Channel.find(params[:channel])
    begin
      params[:page] = params[:page] ||= 1
      Article.update_from_feed(params[:url], params[:channel])
      @articles = Article.where('channel_id = ?', params[:channel]).page(params[:page]).per(10)
      respond_to do |format|
        format.js
      end
    rescue
      @articles = Article.where('channel_id = ?', params[:channel]).page(params[:page]).per(10)
      respond_to do |format|
        format.js
      end
      #render :nothing => true
    end
  end

end
