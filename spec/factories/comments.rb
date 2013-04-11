# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content "This is just a comment"
    user_id 1
    article_id 1
  end
end
