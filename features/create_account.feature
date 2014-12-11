Feature: User Account
  As a user
  I want to have my own account
  So my friends and I can manage our bicycle maintenance

  Scenario: Register for an account
    Given I am an unregistered user
    When I signup for an account
    Then a new account will be created
    And I will be logged in

