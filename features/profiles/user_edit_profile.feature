Feature: Edit User Profile
  As an user in the website
  I want to edit my profile

    Scenario: Editing user profile
      Given I exist as a user
      When I sign in with valid credentials
      Then I should see profile link
      And I go to edit user profile
