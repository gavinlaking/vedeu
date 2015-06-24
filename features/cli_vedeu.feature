Feature: Running 'vedeu'

  Scenario: Without arguments provides a usage message
    When I successfully run `vedeu`
    Then the output should contain ""
