Feature: create a bowling kata directory
  In order to save some time
  As a developer
  I want to run a command to generate the standard files / directories for a code kata

  Scenario: bowling_kata directory doesn't already exist
    Given I want to create the bowling kata in "~/Desktop/bowling/" directory
			And the destination does not already contain a "bowling_kata" directory
    When I run "createkata" with my desired destination
    Then I should have a "bowling_kata" directory
			And I should have a "bowling_kata/features" directory
			And I should have a "bowling_kata/features/step_definitions" directory
			And I should have a "bowling_kata/features/support" directory
			And I should have a "bowling_kata/features/support/env.rb" file
			And I should have a "bowling_kata/lib" directory
			And I should have a "bowling_kata/spec" directory
			And I should have a "bowling_kata/spec/spec_helper.rb" file  
	
	Scenario: bowling_kata directory already exists
	  Given I want to create the bowling kata in "~/Desktop/bowling/" directory
			And the destination does already contain a "bowling_kata" directory
	  When I run "createkata" with my desired destination
	  Then I should have a "bowling_kata_1" directory
			And I should have a "bowling_kata_1/features" directory
			And I should have a "bowling_kata_1/features/step_definitions" directory
			And I should have a "bowling_kata_1/features/support" directory
			And I should have a "bowling_kata_1/features/support/env.rb" file
			And I should have a "bowling_kata_1/lib" directory
			And I should have a "bowling_kata_1/spec" directory
			And I should have a "bowling_kata_1/spec/spec_helper.rb" file

	Scenario: mastermind directory doesn't already exists
	  Given I want to create the mastermind kata in "~/Desktop/mastermind/" directory
			And the destination does not already contain a "mastermind_kata" directory
	  When I run "createkata mastermind" with my desired destination
	  Then I should have a "mastermind_kata" directory
			And I should have a "mastermind_kata/features" directory
			And I should have a "mastermind_kata/features/step_definitions" directory
			And I should have a "mastermind_kata/features/support" directory
			And I should have a "mastermind_kata/features/support/env.rb" file
			And I should have a "mastermind_kata/lib" directory
			And I should have a "mastermind_kata/spec" directory
			And I should have a "mastermind_kata/spec/spec_helper.rb" file

	Scenario: mastermind directory does already exists
	  Given I want to create the mastermind kata in "~/Desktop/mastermind/" directory
			And the destination does already contain a "mastermind_kata" directory
	  When I run "createkata mastermind" with my desired destination
	  Then I should have a "mastermind_kata_1" directory
			And I should have a "mastermind_kata_1/features" directory
			And I should have a "mastermind_kata_1/features/step_definitions" directory
			And I should have a "mastermind_kata_1/features/support" directory
			And I should have a "mastermind_kata_1/features/support/env.rb" file
			And I should have a "mastermind_kata_1/lib" directory
			And I should have a "mastermind_kata_1/spec" directory
			And I should have a "mastermind_kata_1/spec/spec_helper.rb" file
	