module Vedeu

  # Allows the creation of a lock-less log device.
  #
  class MonoLogger < Logger

    # Create a trappable Logger instance.
    #
    # @param logdev [String|IO] The filename (String) or IO object (typically
    #   STDOUT, STDERR or an open file).
    # @return [Vedeu::MonoLogger]
    def initialize(logdev)
      @level             = Logger::DEBUG
      @default_formatter = Logger::Formatter.new
      @formatter         = nil
      @logdev            = Vedeu::LocklessLogDevice.new(logdev) if logdev
    end

  end # MonoLogger

end # Vedeu
