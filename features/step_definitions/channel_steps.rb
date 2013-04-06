Then(/^I should see channels link$/) do
  page.should have_content "Channels"
end

Then(/^I go to create channel$/) do
  visit new_channel_path
  page.should have_content "Url"
end

Then(/^I create the channel$/) do
  url = "http://clarin.feedsportal.com/c/33088/f/577681/index.rss"
  fill_in "channel_url", :with => url
  click_button "Create Channel"
  page.should have_content url
end
