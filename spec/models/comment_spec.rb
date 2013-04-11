require 'spec_helper'

describe Comment do

  it { should validate_presence_of(:content) }
  it { should belong_to(:user) }
  it { should belong_to(:article) }

  before(:each) do
    @user    = FactoryGirl.create(:user)
    @channel = FactoryGirl.create(:channel, :url => "http://ep00.epimg.net/rss/tags/ultimas_noticias.xml")
    @user.channels << @channel
    @article = FactoryGirl.create(:article, :channel_id => @channel.id)

    @comment_one = FactoryGirl.create(:comment, :user_id => @user.id, :article_id => @article.id)
    @comment_two = FactoryGirl.create(:comment, :user_id => @user.id, :article_id => @article.id)
    @comment_three = FactoryGirl.create(:comment, :user_id => @user.id, :article_id => @article.id)
    sleep 0.2
  end

  it "should be a valid" do
    @comment_one.should_not be_nil
  end

  it "should be a certain number of comments for an article" do
    counter = @article.comments.size
    counter.should eql(3)
  end

  it "should delete an article and all comments" do
    @article.destroy
    Comment.all.count eql(0)
  end

  it "should belongs to user" do
    @comment_one.user.id.should eql(@user.id)
  end

end
