module Vedeu

  # Ensures we can always write to the log file by creating a lock-less
  # log device.
  #
  class LocklessLogDevice < Logger::LogDevice

    # Returns a new instance of Vedeu::LocklessLogDevice.
    #
    # @param file_or_filename [void]
    # @return [Vedeu::LocklessLogDevice]
    def initialize(file_or_filename = nil)
      @file_or_filename = file_or_filename
    end

    # @param message [String]
    # @return [void]
    def write(message)
      device.write(message)

    rescue StandardError => exception
      warn("Log writing failed. #{exception}")

    end

    # @return [void]
    def close
      device.close

    rescue
      nil

    end

    protected

    # @!attribute [r] file_or_filename
    # @return [String]
    attr_reader :file_or_filename
    alias_method :file,     :file_or_filename
    alias_method :filename, :file_or_filename

    private

    # @return [File]
    def device
      if file?
        file

      elsif exists?
        open(filename, (File::WRONLY | File::APPEND))

      else
        device      = open(filename, (File::WRONLY | File::APPEND | File::CREAT))
        device.sync = true

      end
    end

    # @return [Boolean]
    def exists?
      FileTest.exist?(filename)
    end

    # @return [Boolean]
    def file?
      file_or_filename.respond_to?(:write) &&
      file_or_filename.respond_to?(:close)
    end

  end # LocklessLogDevice

end # Vedeu
