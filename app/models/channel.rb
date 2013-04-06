require "feedzirra"
require "net/http"
require "feed_validator"

class Channel < ActiveRecord::Base
  attr_accessible :name, :url, :user_id

  belongs_to :user

  #################################################
  # Validations
  validates :name, :url, :user_id, :presence => true
  validates :url, :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

  def self.valid_response_from_url?(url)
    url = URI.parse(url)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)
    res.code == "200" ? true :false
  end

  def self.valid_rss_url?(url)
    v = W3C::FeedValidator.new
    v.validate_url(url) && v.valid? ? true : false
  end

  def self.get_title(url)
    Feedzirra::Feed.fetch_and_parse(url).title
  end

end
