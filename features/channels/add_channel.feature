Feature: Create Channel
  As an user in the website
  I want to add a new channel

    Scenario: Adding new channel
      Given I exist as a user
      When I sign in with valid credentials
      Then I should see channels link
      And I go to create channel
      Then I create the channel
