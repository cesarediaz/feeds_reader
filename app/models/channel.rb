require "feedzirra"
require "net/http"
require "feed_validator"
require 'hpricot'

class Channel < ActiveRecord::Base
  attr_accessible :name, :url

  has_and_belongs_to_many :users
  has_many :articles, :order => "created_at ASC", :dependent => :destroy
  #################################################
  # Validations
  validates :name, :url, :presence => true
  validates :url, :format => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix


  after_create do |channel|
    Article.update_from_feed(channel.url, channel.id)
  end


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

  def self.get_title(link)
    doc = Hpricot.parse(open(link))
    return doc.at("//title").inner_html
  end

end
