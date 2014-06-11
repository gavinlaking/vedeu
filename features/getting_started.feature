Feature: Getting Started

  Scenario: Hello World
    Given the interface "main" is defined
    And the command "hello" is defined
    When the input "hello" is entered
    Then the output should contain:
      """
      Hello World!
      """
