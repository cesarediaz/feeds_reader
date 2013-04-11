require 'spec_helper'

describe ChannelsUsers do

  before(:each) do
   @user_one = FactoryGirl.create(:user)
   @user_two = FactoryGirl.create(:user, :email => 'matts@hotmail.com')
   @channel = FactoryGirl.create(:channel, :url => 'http://ep00.epimg.net/rss/tags/ultimas_noticias.xml')
   @user_one.channels << @channel
   @user_two.channels << @channel
   sleep 0.2
  end

  it "user should have one channel" do
    ChannelsUsers.channel_exist_for_user?(@user_one, @channel).should eql(1)
  end

  it "should exist for two users" do
    ChannelsUsers.channel_counter(@channel.id).should eql(2)
  end

  it "should delete the channel from the intermediate table for an user" do
    ChannelsUsers.channel_counter(@channel.id).should eql(2)
    ChannelsUsers.delete_channel_for_user(@channel.id, @user_one.id)
    ChannelsUsers.channel_counter(@channel.id).should eql(1)
  end

  it "should delete the channel from channels table" do
    ChannelsUsers.channel_counter(@channel.id).should eql(2)
    ChannelsUsers.delete_channel_for_user(@channel.id, @user_one.id)
    ChannelsUsers.delete_channel_for_user(@channel.id, @user_two.id)
    ChannelsUsers.channel_counter(@channel.id).should eql(0)
  end
end
