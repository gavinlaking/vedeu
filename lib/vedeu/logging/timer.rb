# frozen_string_literal: true

module Vedeu

  module Logging

    # Measure the duration. Used for debugging.
    # The configuration option 'debug' must be set to true to enable
    # this functionality.
    #
    class Timer

      class << self

        # {include:file:docs/dsl/by_method/timer.md}
        # @param message [String]
        # @param block [Proc]
        # @macro raise_requires_block
        # @return [void] The return value of the executed block.
        def timer(message = '', &block)
          new(message).measure(&block)
        end

      end # Eigenclass

      # Returns a new instance of Vedeu::Logging::Timer.
      #
      # @param message [String]
      # @return [Vedeu::Logging::Timer]
      def initialize(message = '')
        @message = message
        @started = Vedeu.clock_time
      end

      # Write an entry to the log file stating how long a section of
      # code took in milliseconds when debugging is enabled and a
      # block was Useful for debugging performance.
      #
      # @param block [Proc]
      # @macro raise_requires_block
      # @return [void|NilClass] The return value of the executed
      #   block if given, or nil if debugging is disabled.
      def measure(&block)
        if block_given?
          if Vedeu.config.debug?
            work = yield

            Vedeu.log(type:    :timer,
                      message: "#{message} took #{elapsed}ms.")

            work

          else
            yield

          end

        else
          fail Vedeu::Error::RequiresBlock if Vedeu.config.debug?

        end
      end

      protected

      # @!attribute [r] started
      # @return [Time]
      attr_reader :started

      # @!attribute [r] message
      # @return [String]
      attr_reader :message

      private

      # Returns the elapsed time in milliseconds with 3 decimal
      # places.
      #
      # @return [Float]
      def elapsed
        ((Vedeu.clock_time - started) * 1000).round(3)
      end

    end # Timer

  end # Logging

  # {include:file:docs/dsl/by_method/timer.md}
  # @api public
  # @!method timer
  #   @see Vedeu::Logging::Timer.timer
  def_delegators Vedeu::Logging::Timer,
                 :timer

end # Vedeu
