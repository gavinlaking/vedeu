module Vedeu

  # Classes within the Output namespace handle various aspects of
  # rendering content.
  #
  module Output

    # Sends the output to the renderers.
    #
    class Output

      # Writes output to the defined renderers.
      #
      # @return [Array|String]
      # @see #initialize
      def self.render_output(output)
        new(output).render_output
      end

      # Return a new instance of Vedeu::Output::Output.
      #
      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [Vedeu::Output::Output]
      def initialize(output)
        @output = output
      end

      # Send the view to the renderers. If the output is a
      # {Vedeu::Models::Escape} object (typical when showing or
      # hiding the cursor) then we bypass the
      # {Vedeu::Terminal::Buffer} and write directly to the terminal
      # because escape sequences only make sense to the terminal and
      # not other renderers.
      #
      # @return [Array|NilClass]
      def render_output
        return nil if output.nil?
        return render_terminal_buffer unless output.is_a?(Vedeu::Models::Escape)

        Vedeu::Output::Direct.write(value: output.value,
                                    x:     output.position.x,
                                    y:     output.position.y)
      end

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Views::Char>>]
      attr_reader :output

      # @return [Array]
      def render_terminal_buffer
        Vedeu.hide_cursor(Vedeu.focus)

        Vedeu::Terminal::Buffer.write(output).render

        Vedeu.show_cursor(Vedeu.focus)
      end

    end # Output

  end # Output

  # Write the given output to the configured or default renderers.
  #
  # @example
  #   Vedeu.render_output(output)
  #
  # @!method render_output
  # @return [Array|NilClass]
  def_delegators Vedeu::Output::Output, :render_output

end # Vedeu
