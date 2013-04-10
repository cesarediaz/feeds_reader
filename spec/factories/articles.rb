# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "Article one"
    description "This is the article one"
    link "http://www.articleone.com/article/1"
    pubDate "2013-04-07 18:47:12"
    guid "article-one"
    channel_id 1
  end
end
