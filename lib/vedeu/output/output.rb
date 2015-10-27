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
      # @return [Array|NilClass|String]
      # @see #initialize
      def self.render_output(output)
        return nil if output.nil?

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
      # @return [Array|String|NilClass]
      def render_output
        if escape_sequence?
          direct_write!

        else
          buffer_write!

        end
      end

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Views::Char>>|
      #   NilClass|Vedeu::Models::Escape]
      attr_reader :output

      private

      # @return [Array]
      def buffer_write!
        Vedeu::Terminal::Buffer.write(output)
      end

      # @return [Array<String>]
      def direct_write!
        Vedeu::Terminal.output(output.to_s)
      end

      # @return [Boolean]
      def escape_sequence?
        output.is_a?(Vedeu::Models::Escape)
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
  def_delegators Vedeu::Output::Output,
                 :render_output

end # Vedeu
