Feature: Delete User Profile
  As an user in the website
  I want to delete my profile

    Scenario: Deleting user profile
      Given I exist as a user
      When I sign in with valid credentials
      Then I should see profile link
      And I go to delete user profile
      Then I should see create profile ad
