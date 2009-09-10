Feature: pulling kata templates from github
  In order to get new katas to solve
  As a programmer
  I want to pull kata templates from github

  Scenario: first time downloading the default repo
    Given I don't have a github repo specified
      And I haven't cloned the repo yet
    Then it should clone the default repo from github to "~/.katas/templates/"
      And it should copy the .feature files to the "destination/features" directory
      And it should copy the _steps.rb files to the "destination/features/step_definitions" directory
      And it should copy the _spec.rb files to the "destination/spec" directory
    When I run "createkata -g bowling"

  Scenario: first time downloading a forked repo
    Given I do have a github repo specified
      And I haven't cloned the repo yet
    Then it should clone my specified repo from github to "~/.katas/templates/"
      And it should copy the .feature files to the "destination/features" directory
      And it should copy the _steps.rb files to the "destination/features/step_definitions" directory
      And it should copy the _spec.rb files to the "destination/spec" directory
    When I run "createkata -g bowling"

  Scenario: clone of default repo exists
    Given I don't have a github repo specified
      And I have cloned the repo already
    Then it should update the default repo from github
      And it should copy the .feature files to the "destination/features" directory
      And it should copy the _steps.rb files to the "destination/features/step_definitions" directory
      And it should copy the _spec.rb files to the "destination/spec" directory
    When I run "createkata -g bowling"

  Scenario: clone of default repo exists
    Given I do have a github repo specified
      And I have cloned the repo already
    Then it should update my specified repo from github
      And it should copy the .feature files to the "destination/features" directory
      And it should copy the _steps.rb files to the "destination/features/step_definitions" directory
      And it should copy the _spec.rb files to the "destination/spec" directory
    When I run "createkata -g bowling"
