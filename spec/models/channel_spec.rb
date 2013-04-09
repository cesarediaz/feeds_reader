require 'spec_helper'

describe Channel do

  it { should validate_presence_of(:name) }
  it { should have_and_belong_to_many(:users) }
  it { should have_many(:articles) }

  it "should be a valid rss url" do
    url = Channel.valid_rss_url?("http://ep00.epimg.net/rss/tags/ultimas_noticias.xml")
    url.should be_true
  end

  it "should be an invalid rss url" do
    url = Channel.valid_rss_url?("http://www.campolitoral.com.ar/estatico/campo.xml")
    url.should be_false
  end

  it "should be a valid response from url" do
    response = Channel.valid_response_from_url?("http://ep00.epimg.net/rss/tags/ultimas_noticias.xml")
    response.should be_true
  end

  it "should be an invalid response from url" do
    response = Channel.valid_response_from_url?("http://ep00.epimg.net/rss/tags/ultimas_noticias")
    response.should be_false
  end

end
