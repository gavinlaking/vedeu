module Vedeu

  # Measure the duration. Used for debugging.
  class Timer

    # @param type [Symbol]
    # @param message [String]
    # @param block [Proc]
    # @return [void]
    def self.for(type = :debug, message = '', &block)
      new(type, message).measure(&block)
    end

    # @param type [Symbol]
    # @param message [String]
    # @return [Vedeu::Timer]
    def initialize(type = :debug, message = '')
      @type    = type
      @message = message
      @started = Time.now.to_f
    end

    # @param block [Proc]
    # @return [void]
    def measure(&block)
      work = yield

      elapsed = ((Time.now.to_f - started) * 1000).to_i

      Vedeu.log(type: type, message: "#{message} took #{elapsed}ms.")

      work
    end

    protected

    # @!attribute [r] started
    # @return [Time]
    attr_reader :started

    # @!attribute [r] message
    # @return [String]
    attr_reader :message

    # @!attribute [r] type
    # @return [Symbol]
    attr_reader :type

  end # Timer

end # Vedeu
