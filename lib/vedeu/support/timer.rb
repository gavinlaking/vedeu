module Vedeu

  # Measure the duration. Used for debugging.
  #
  # @api public
  class Timer

    class << self

      # @param message [String]
      # @param block [Proc]
      # @return [void]
      def timer(message = '', &block)
        new(message).measure(&block)
      end

    end

    # @param message [String]
    # @return [Vedeu::Timer]
    def initialize(message = '')
      @message = message
      @started = Time.now.to_f
    end

    # @return [void]
    def measure
      work = yield

      elapsed = ((Time.now.to_f - started) * 1000).round(3)

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

  end # Timer

end # Vedeu
