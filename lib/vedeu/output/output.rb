# frozen_string_literal: true

module Vedeu

  # Classes within the Output namespace handle various aspects of
  # rendering content.
  #
  module Output

    # Sends the output to the renderers.
    #
    class Output

      include Vedeu::Common

      class << self

        # @param (see #output)
        # @return (see #buffer_update)
        def buffer_update(output)
          new(output).buffer_update
        end

        # @param (see #output)
        # @return (see #buffer_write)
        def buffer_write(output)
          new(output).buffer_write
        end

        # @param (see #output)
        # @return (see #direct_write)
        def direct_write(output)
          new(output).direct_write
        end

        # Writes output to the defined renderers.
        #
        # @param (see #output)
        # @return (see #render_output)
        def render_output(output)
          new(output).render_output
        end

      end # Eigenclass

      # Return a new instance of Vedeu::Output::Output.
      #
      # @param (see #output)
      # @return [Vedeu::Output::Output]
      def initialize(output)
        @output = output
      end

      # @return (see #render_output)
      def buffer_update
        Vedeu::Buffers::Terminal.update(output) if present?(output)
      end

      # @return (see #render_output)
      def buffer_write
        Vedeu::Buffers::Terminal.write(output) if present?(output)
      end

      # @return (see #render_output)
      def direct_write
        Vedeu::Terminal.output(output.to_s) if present?(output)
      end

      # Send the view to the renderers. If the output is a
      # {Vedeu::Cells::Escape} object (typical when showing or
      # hiding the cursor) then we bypass the
      # {Vedeu::Buffers::Terminal} and write directly to the terminal
      # because escape sequences only make sense to the terminal and
      # not other renderers.
      #
      # @return [Array<String>|String|NilClass]
      def render_output
        if escape?(output)
          direct_write

        else
          buffer_write

        end
      end

      protected

      # @!attribute [r] output
      # @return [Array<Array<Vedeu::Cells::Char>>|
      #   NilClass|Vedeu::Cells::Escape|Vedeu::Cells::Cursor]
      attr_reader :output

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
  # @return (see Vedeu::Output::Output#render_output)
  def_delegators Vedeu::Output::Output,
                 :buffer_update,
                 :buffer_write,
                 :direct_write,
                 :render_output

end # Vedeu
