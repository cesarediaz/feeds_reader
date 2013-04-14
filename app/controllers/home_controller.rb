class HomeController < ApplicationController
  def index
    if user_signed_in? && !current_user.channels.empty?
      @starred_articles_ids = current_user.articles.map { |r| r.id }
      channel_id = params[:channel_id] ||= current_user.channels.first.id
      @channel = Channel.find(channel_id)
      @articles = @channel.articles.page(params[:page])
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
end
