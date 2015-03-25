module Vedeu

  # Converts a grid of {Vedeu::Char} objects into a stream of escape sequences
  # and content suitable for a terminal.
  #
  class TerminalRenderer

    # @param output [Array<Array<Vedeu::Char>>]
    # @return [String]
    def self.render(*output)
      new(*output).render
    end

    # Returns a new instance of Vedeu::TerminalRenderer.
    #
    # @param output [Array<Array<Vedeu::Char>>]
    # @return [Vedeu::TerminalRenderer]
    def initialize(*output)
      @output = output
    end

    # @return [Array<String>]
    def render
      Vedeu::Terminal.output(hide_cursor, parsed, show_cursor)
    end

    private

    # @!attribute [r] output
    # @return [Array<Array<Vedeu::Char>>]
    attr_reader :output

    # @return [String]
    def show_cursor
      Vedeu::Esc.string(:show_cursor)
    end

    # @return [String]
    def parsed
      output.flatten.map(&:to_s).join
    end

    # @return [String]
    def hide_cursor
      Vedeu::Esc.string(:hide_cursor)
    end

  end # TerminalRenderer

end # Vedeu
