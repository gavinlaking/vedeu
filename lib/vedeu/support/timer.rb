module Vedeu

  # Measure the duration. Used for debugging.
  #
  # @api public
  class Timer

    class << self

      # @example
      #   Vedeu.timer 'message' do
      #     # ... code to be measured
      #   end
      #
      # @param message [String]
      # @param block [Proc]
      # @return [void]
      def timer(message = '', &block)
        new(message).measure(&block)
      end

    end

    # Returns a new instance of Vedeu::Timer.
    #
    # @param message [String]
    # @return [Vedeu::Timer]
    def initialize(message = '')
      @message = message
      @started = Time.now.to_f
    end

    # Write an entry to the log file stating how long a section of code took in
    # milliseconds. Useful for debugging performance.
    #
    # @return [void]
    def measure
      work = yield

      Vedeu.log(type: :timer, message: "#{message} took #{elapsed}ms.")

      work
    end

    protected

    # @!attribute [r] started
    # @return [Time]
    attr_reader :started

    # @!attribute [r] message
    # @return [String]
    attr_reader :message

    # Returns the elapsed time in milliseconds with 3 decimal places.
    #
    # @return [Float]
    def elapsed
      ((Time.now.to_f - started) * 1000).round(3)
    end

  end # Timer

end # Vedeu
