require 'spec_helper'

describe ChannelsUsers do

  before(:each) do
   @user = FactoryGirl.create(:user)
   @channel = FactoryGirl.create(:channel, :url => "http://ep00.epimg.net/rss/tags/ultimas_noticias.xml")
   @user.channels << @channel
  end

  it "user should have one channel" do
    ChannelsUsers.channel_exist_for_user?(@user, @channel).should eql(1)
  end

end
