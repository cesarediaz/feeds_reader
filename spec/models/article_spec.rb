require 'spec_helper'

describe Article do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:link) }
  it { should validate_presence_of(:pubDate) }
  it { should validate_presence_of(:guid) }
  it { should belong_to(:channel) }
  it { should have_many(:comments) }

  before(:each) do
    @article = FactoryGirl.create(:article)
    sleep 0.2
  end

  it "should be a valid" do
    @article.should_not be_nil
  end

end
