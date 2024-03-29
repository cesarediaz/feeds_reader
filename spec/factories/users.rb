FactoryGirl.define do
  factory :user do
    login 'TestUser'
    first_name 'Clark'
    last_name 'Kent'
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
end
