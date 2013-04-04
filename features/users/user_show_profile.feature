Feature: Show User Profile
  As an user in the website
  I want to see my profile

    Scenario: Viewing user profile
      Given I exist as a user
      When I sign in with valid credentials
      Then I should see profile link
      And I go to user profile
