module Vedeu

  module Logging

    # If the system supports Process::CLOCK_MONOTONIC use that for
    # timestamps.
    #
    #    Vedeu.clock_time # => 15217.232113 (Process::CLOCK_MONOTONIC)
    #                     # => 1447196800.3098037 (Time.now)
    #
    module ClockTime

      if defined?(Process::CLOCK_MONOTONIC)
        def self.clock_time
          Process.clock_gettime(Process::CLOCK_MONOTONIC)
        end

      else
        def self.clock_time
          Time.now
        end

      end

    end # ClockTime

  end # Logging

  # @!method clock_time
  #   @see Vedeu::Logging::ClockTime
  def_delegators Vedeu::Logging::ClockTime,
                 :clock_time

end # Vedeu
