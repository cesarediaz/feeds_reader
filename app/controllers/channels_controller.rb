class ChannelsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_channel, :only => [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @channel = Channel.new
  end

  def create
    begin
      url = params[:channel][:url] if params[:channel][:url].present?

      if channel_is_valid?(url)
        name = Channel.get_title(url)
        unless Channel.where("name = ?", name).exists?

          params[:channel][:name] = name
          @channel = Channel.new(params[:channel])

          if @channel.save
            add_channel_to_user(@channel)
            flash[:notice] = Hpricot.uxs("Added #{@channel.name}!")
            redirect_to "/"
          else
            render :action => "new"
          end

        else
          channel = find_channel_by_name(name)
          add_channel_to_user(channel)
          redirect_to "/"
        end
      else
        flash[:alert] = 'Add a valid rss feeds url'
        redirect_to new_channel_path
      end
    rescue
        flash[:alert] = 'Something went wrong! Please try again'
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
    flash[:notice] = "Deleted #{@channel.name}!"
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
    current_user.channels << channel
  end

  def find_channel_by_name(name)
    Channel.where("name = ?", name)
  end
end
