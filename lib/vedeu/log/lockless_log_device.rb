module Vedeu

  # Ensures we can always write to the log file by creating a lock-less
  # log device.
  #
  class LocklessLogDevice < Logger::LogDevice

    # Returns a new instance of Vedeu::LocklessLogDevice.
    #
    # @param log [void]
    # @return [Vedeu::LocklessLogDevice]
    def initialize(log = nil)
      @dev      = nil
      @filename = nil

      if log.respond_to?(:write) && log.respond_to?(:close)
        @dev = log

      else
        @dev      = open_logfile(log)
        @dev.sync = true
        @filename = log

      end
    end

    # @param message [String]
    # @return [void]
    def write(message)
      @dev.write(message)

    rescue StandardError => exception
      warn("log writing failed. #{exception}")
    end

    # @return [void]
    def close
      @dev.close
    rescue
      nil
    end

    private

    # @param log [String]
    # @return [void]
    def open_logfile(log)
      if FileTest.exist?(log)
        open(log, (File::WRONLY | File::APPEND))

      else
        logdev = open(log, (File::WRONLY | File::APPEND | File::CREAT))
        logdev.sync = true
        logdev

      end
    end

  end # LocklessLogDevice

end # Vedeu

# module Vedeu

#   # Ensures we can always write to the log file by creating a lock-less
#   # log device.
#   #
#   class LocklessLogDevice < Logger::LogDevice

#     # Returns a new instance of Vedeu::LocklessLogDevice.
#     #
#     # @param file_or_filename [void]
#     # @return [Vedeu::LocklessLogDevice]
#     def initialize(file_or_filename = nil)
#       @file_or_filename = file_or_filename
#     end

#     # @param message [String]
#     # @return [void]
#     def write(message)
#       device.write(message)

#     rescue StandardError => exception
#       warn("Log writing failed. #{exception}")

#     end

#     # @return [void]
#     def close
#       device.close

#     rescue
#       nil

#     end

#     protected

#     # @!attribute [r] file_or_filename
#     # @return [String]
#     attr_reader :file_or_filename
#     alias_method :file,     :file_or_filename
#     alias_method :filename, :file_or_filename

#     private

#     # @return [File]
#     def device
#       if file?
#         file

#       elsif exists?
#         open(filename, (File::WRONLY | File::APPEND))

#       else
#         device      = open(filename, (File::WRONLY | File::APPEND | File::CREAT))
#         device.sync = true

#       end
#     end

#     # @return [Boolean]
#     def exists?
#       FileTest.exist?(filename)
#     end

#     # @return [Boolean]
#     def file?
#       file_or_filename.respond_to?(:write) &&
#       file_or_filename.respond_to?(:close)
#     end

#   end # LocklessLogDevice

# end # Vedeu
