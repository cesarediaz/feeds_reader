class ArticlesController < ApplicationController
  def add_articles
    @channel = Channel.find(params[:channel])
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
      #render :nothing => true
    end
  end

end
