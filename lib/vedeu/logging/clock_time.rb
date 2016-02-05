# frozen_string_literal: true

module Vedeu

  module Logging

    # If the system supports Process::CLOCK_MONOTONIC use that for
    # timestamps.
    #
    # @api public
    #
    module ClockTime

      # {include:file:docs/dsl/by_method/clock_time.md}
      # @return [Float|Time]
      def self.clock_time
        if defined?(Process::CLOCK_MONOTONIC)
          Process.clock_gettime(Process::CLOCK_MONOTONIC)

        else
          Time.now

        end
      end

    end # ClockTime

  end # Logging

  # @api public
  # @!method clock_time
  # {include:file:docs/dsl/by_method/clock_time.md}
  def_delegators Vedeu::Logging::ClockTime,
                 :clock_time

end # Vedeu
