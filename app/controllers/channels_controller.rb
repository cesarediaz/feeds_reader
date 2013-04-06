class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_channel, :only => [:show, :edit, :update, :destroy]

  def index
    @channels = Channel.where('user_id = ?', current_user.id)
  end

  def new
    @channel = Channel.new
  end

  def create
    begin
      if Channel.valid_rss_url?(params[:channel][:url])
        params[:channel][:user_id] = current_user.id
        params[:channel][:name] = Channel.get_title(params[:channel][:url])
        @channel = Channel.new(params[:channel])
        if @channel.save
          redirect_to(@channel)
        else
          render :action => "new"
        end
      end
    rescue
      render :action => "new"
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

end
