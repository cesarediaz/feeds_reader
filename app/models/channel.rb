require "feedzirra"
require "net/http"

class Channel < ActiveRecord::Base
  attr_accessible :name, :url, :user_id

  belongs_to :user

  #################################################
  # Validations
  validates :name, :url, :user_id, :presence => true

  def self.valid_rss_url?(url)
    url = URI.parse(url)
    req = Net::HTTP.new(url.host, url.port)
    res = req.request_head(url.path)
    res.code == "200" ? true :false
  end

  def self.get_title(url)
    Feedzirra::Feed.fetch_and_parse(url).title
  end

end
