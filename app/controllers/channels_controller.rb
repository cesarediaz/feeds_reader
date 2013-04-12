class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_channel, :only => [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @channel = Channel.new
    respond_to do |format|
      format.js
      format.html
    end
  end

  def create
    begin
      url = params[:channel][:url] if params[:channel][:url].present?

      if channel_is_valid?(url)
        name = Channel.get_title(url)
        unless Channel.where("name = ?", name).exists?
          params[:channel][:name] = name
          @channel = Channel.new(params[:channel])
          save(@channel)
        else
          channel = find_channel_by_name(name)
          @alert = add_channel_to_user(channel)
          flash[:alert] = @alert
          render :new
        end
      else
        flash[:alert] = 'Add a valid rss feeds url'
        redirect_to new_channel_path
      end
    rescue
        flash[:alert] = @alert ||= 'Something went wrong.. try again!!'
        redirect_to new_channel_path
    end
  end

  def show
  end

  def edit
    respond_to do |format|
      format.js
      format.html
    end
  end

  def update
    if @channel.update_attributes(params[:channel])
      redirect_to channel_path
    else
      render :edit
    end
  end

  def destroy
    flash[:notice] = Hpricot.uxs("Deleted #{@channel.name}!")
    counter = ChannelsUsers.channel_counter(@channel.id)
    counter > 1 ? ChannelsUsers.delete_channel_for_user(@channel.id, current_user.id) : @channel.destroy
    redirect_to "/"
  end

  private

  def get_channel
    @channel = Channel.find(params[:id])
  end

  def channel_is_valid?(url)
    Channel.valid_rss_url?(url) && Channel.valid_response_from_url?(url) && Channel.get_title(url) ? true : false
  end

  def add_channel_to_user(channel)
    if ChannelsUsers.channel_exist_for_user?(channel.id, current_user.id) < 1
      current_user.channels << channel
      @alert = Hpricot.uxs("Channel '#{channel.name}' added! Do you want to add a new channel?")
    else
      @alert = Hpricot.uxs("You already have added this channel!")
    end
    return @alert
  end

  def find_channel_by_name(name)
    Channel.where("name = ?", name).first
  end

  def save(channel)
    if channel.save
      add_channel_to_user(channel)
      flash[:notice] = Hpricot.uxs("Added #{channel.name}!")
      redirect_to "/"
    else
      render :action => "new"
    end
  end
end
