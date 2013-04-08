require 'spec_helper'

describe Article do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:link) }
  it { should validate_presence_of(:pubDate) }
  it { should belong_to(:channel) }

  before(:each) do
    @article = FactoryGirl.create(:article)
  end

  it "should be a valid" do
    @article.should_not be_nil
  end

end
