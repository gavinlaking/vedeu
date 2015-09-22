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
      def self.render(output)
        new(output).render
      end

      # Return a new instance of Vedeu::Output::Output.
      #
      # @param output [Array<Array<Vedeu::Views::Char>>]
      # @return [Vedeu::Output::Output]
      def initialize(output)
        @output = output
      end

      # Send the view to the renderers.
      #
      # @return [Array]
      def render
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
        Vedeu::Terminal::Buffer.write(output).render
      end

    end # Output

  end # Output

end # Vedeu
