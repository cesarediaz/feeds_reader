class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_channel, :only => [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @channel = Channel.new
  end

  def create
    if params[:channel][:url].present? && channel_is_valid?(params[:channel][:url])
      params[:channel][:user_id] = current_user.id
      params[:channel][:name] = Channel.get_title(params[:channel][:url])
      @channel = Channel.new(params[:channel])
      if @channel.save
        redirect_to(@channel) && return
      else
        render :action => "new"
      end
    else
      flash[:alert] = 'Add a valid rss feeds url'
      redirect_to new_channel_path
    end
  end

  def show
  end

  def edit
  end

  def update
    if @channel.update_attributes(params[:channel])
      redirect_to channel_path
    else
      render :edit
    end
  end

  def destroy
    @channel.destroy
    redirect_to channels_path
  end

  private

  def get_channel
    @channel = Channel.find(params[:id])
  end

  def channel_is_valid?(url)
    Channel.valid_rss_url?(url) && Channel.valid_response_from_url?(url) && Channel.get_title(url) ? true : false
  end
end
