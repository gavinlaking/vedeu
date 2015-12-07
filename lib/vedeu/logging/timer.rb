module Vedeu

  module Logging

    # Measure the duration. Used for debugging.
    # The configuration option 'debug' must be set to true to enable
    # this functionality.
    #
    class Timer

      class << self

        # Measure the execution time of the code in the given block.
        # The message provided will have ' took <time>ms.' appended.
        #
        # @example
        #   Vedeu.timer 'Really complex code' do
        #     # ... code to be measured
        #   end
        #
        #   # => 'Really complex code took 0.234ms.'
        #
        # @param message [String]
        # @param block [Proc]
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
      # code took in milliseconds. Useful for debugging performance.
      #
      # @param block [Proc]
      # @raise [Vedeu::Error::RequiresBlock]
      # @return [void] The return value of the executed block.
      def measure(&block)
        fail Vedeu::Error::RequiresBlock unless block_given?

        if Vedeu::Configuration.debug?
          work = yield

          Vedeu.log(type:    :timer,
                    message: "#{message} took #{elapsed}ms.".freeze)

          work

        else
          yield

        end
      end

      protected

      # @!attribute [r] started
      # @return [Time]
      attr_reader :started

      # @!attribute [r] message
      # @return [String]
      attr_reader :message

      # Returns the elapsed time in milliseconds with 3 decimal
      # places.
      #
      # @return [Float]
      def elapsed
        ((Vedeu.clock_time - started) * 1000).round(3)
      end

    end # Timer

  end # Logging

  # Measure the execution time of the code in the given block.
  #
  # @example
  #   Vedeu.timer do
  #     # ... some code here ...
  #   end
  #
  # @!method timer
  #   @see Vedeu::Logging::Timer.timer
  def_delegators Vedeu::Logging::Timer,
                 :timer

end # Vedeu
