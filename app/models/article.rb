require "feedzirra"

class Article < ActiveRecord::Base
  paginates_per 15

  attr_accessible :channel_id, :description, :link, :pubDate, :title, :guid

  belongs_to :channel
  has_many :comments, :order => "created_at DESC", :dependent => :destroy

  has_and_belongs_to_many :users

  #################################################
  # Validations
  validates :link, :channel_id, :title, :pubDate, :guid, :presence => true


  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def self.update_from_feed(feed_url, channel)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries, channel)
  end

   private

  def self.add_entries(entries, channel)
    entries.each do |entry|
      unless exists? :guid => entry.entry_id
        create!(
          :title         => entry.title,
          :description   => entry.summary,
          :link          => entry.url,
          :pubDate       => entry.published,
          :channel_id    => channel,
          :guid          => entry.entry_id
        )
      end
    end
  end
end
