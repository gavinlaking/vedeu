module Vedeu

  # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
  # and content suitable for a terminal.
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
    end

    # @return [String]
    def render
      File.open("/tmp/out_#{Time.now.to_f}", 'w') { |f| f.write(parsed) }
    end

    private

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

    # @return [String]
    def parsed
      Array(output).flatten.map(&:to_s).join
    end

  end # FileRenderer

end # Vedeu
