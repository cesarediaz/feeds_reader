class HomeController < ApplicationController
  def index
    if user_signed_in? && !current_user.channels.empty?
      channel_id = params[:channel_id] ||= current_user.channels.first.id
      @channel = Channel.find(channel_id)
      @articles = Article.where('channel_id = ?', channel_id).page(params[:page]).per(10)
    end
    @users = User.all
  end
end
