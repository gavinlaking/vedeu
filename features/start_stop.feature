Feature: Starting and stopping a client application

  @basic
  Scenario: The simplest thing that could work
    Given a file named "simple.rb" with mode "0755" and with:
      """ruby
      require 'vedeu'

      class VedeuTestApp
        include Vedeu

        configure do
          debug!
          log '/tmp/vedeu_test_helper.log'
        end

        def self.start(argv = ARGV)
          Vedeu::Launcher.execute!(argv)
        end
      end

      VedeuTestApp.start(ARGV)
      """
    When I run `ruby simple.rb` interactively
    And I type "q"
    And I close the stdin stream
    Then the exit status should be 1
