module Vedeu

  # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
  # and content suitable for a terminal, and writes them to a file in the /tmp
  # directory.
  #
  class FileRenderer

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(*output)
      new(*output).render
    end

    # Returns a new instance of Vedeu::FileRenderer.
    #
    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::FileRenderer]
    def initialize(*output)
      @output  = output
      @options = {}
    end

    # @return [String]
    def render
      File.open("/tmp/#{filename}", 'w') { |f| f.write(parsed) }
    end

    private

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

    def filename
      if timestamp?
        "out_#{timestamp}"

      else
        'out'

      end
    end

    # @return [String]
    def parsed
      Vedeu::Compressor.new(output).render
    end

    def timestamp
      Time.now.to_f
    end

    def timestamp?
      options[:timestamp]
    end

    def options
      defaults.merge!(@options)
    end

    def defaults
      {
        timestamp: false
      }
    end

  end # FileRenderer

end # Vedeu
