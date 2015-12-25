# frozen_string_literal: true

module Vedeu

  # Classes within the Output namespace handle various aspects of
  # rendering content.
  #
  module Output

    # Sends the output to the renderers.
    #
    class Output

      # @param output [Array<Array<Vedeu::Views::Char>>|
      #   NilClass|Vedeu::Cells::Escape]
      # @return [Array]
      def self.buffer_update(output)
        return nil if output.nil?

        new(output).buffer_update
      end

      # @param output [Array<Array<Vedeu::Views::Char>>|
      #   NilClass|Vedeu::Cells::Escape]
      # @return [Array]
      def self.buffer_write(output)
        return nil if output.nil?

        new(output).buffer_write
      end

      # @param output [Array<Array<Vedeu::Views::Char>>|
      #   NilClass|Vedeu::Cells::Escape]
      # @return [Array<String>]
      def self.direct_write(output)
        return nil if output.nil?

        new(output).direct_write
      end

      # Writes output to the defined renderers.
      #
      # @param output [Array<Array<Vedeu::Views::Char>>|
      #   NilClass|Vedeu::Cells::Escape]
      # @return [Array|NilClass|String]
      def self.render_output(output)
        return nil if output.nil?

        new(output).render_output
      end

      # Return a new instance of Vedeu::Output::Output.
      #
      # @param output [Array<Array<Vedeu::Views::Char>>|
      #   NilClass|Vedeu::Cells::Escape]
      # @return [Vedeu::Output::Output]
      def initialize(output)
        @output = output
      end

      # @return [Array]
      def buffer_update
        Vedeu::Buffers::Terminal.update(output)
      end

      # @return [Array]
      def buffer_write
        Vedeu::Buffers::Terminal.write(output)
      end

      # @return [Array<String>]
      def direct_write
        Vedeu::Terminal.output(output.to_s)
      end

      # Send the view to the renderers. If the output is a
      # {Vedeu::Cells::Escape} object (typical when showing or
      # hiding the cursor) then we bypass the
      # {Vedeu::Buffers::Terminal} and write directly to the terminal
      # because escape sequences only make sense to the terminal and
      # not other renderers.
      #
      # @return [Array|String|NilClass]
      def render_output
        if escape_sequence?
          direct_write

        else
          buffer_write

        end
      end

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Views::Char>>|
      #   NilClass|Vedeu::Cells::Escape]
      attr_reader :output

      private

      # @return [Boolean]
      def escape_sequence?
        output.is_a?(Vedeu::Cells::Escape)
      end

    end # Output

  end # Output

  # Write the given output to the configured or default renderers.
  #
  # @example
  #   Vedeu.buffer_update(output)
  #   Vedeu.buffer_write(output)
  #   Vedeu.direct_write(output)
  #   Vedeu.render_output(output)
  #
  # @!method render_output
  # @return [Array|NilClass]
  def_delegators Vedeu::Output::Output,
                 :buffer_update,
                 :buffer_write,
                 :direct_write,
                 :render_output

end # Vedeu
