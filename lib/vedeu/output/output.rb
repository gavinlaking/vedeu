# frozen_string_literal: true

module Vedeu

  module Output

    # Sends the output to the renderers.
    #
    # @api public
    #
    class Output

      include Vedeu::Common

      class << self

        # @param (see Vedeu::Output::Output#initialize)
        # @return (see Vedeu::Output::Output#buffer_update)
        def buffer_update(output)
          new(output).buffer_update
        end

        # @param (see Vedeu::Output::Output#initialize)
        # @return (see Vedeu::Output::Output#buffer_write)
        def buffer_write(output)
          new(output).buffer_write
        end

        # @param (see Vedeu::Output::Output#initialize)
        # @return (see Vedeu::Output::Output#direct_write)
        def direct_write(output)
          new(output).direct_write
        end

        # {include:file:docs/dsl/by_method/render_output.md}
        #
        # @param (see Vedeu::Output::Output#initialize)
        # @return (see Vedeu::Output::Output#render_output)
        def render_output(output)
          new(output).render_output
        end

      end # Eigenclass

      # Return a new instance of Vedeu::Output::Output.
      #
      # @param output [String]
      # @return [Vedeu::Output::Output]
      def initialize(output)
        @output = output
      end

      # @return (see #render_output)
      def buffer_update
        Vedeu::Buffers::Terminal.update(output) if output?
      end

      # @return (see #render_output)
      def buffer_write
        Vedeu::Buffers::Terminal.write(output) if output?
      end

      # @return (see #render_output)
      def direct_write
        Vedeu::Terminal.output(output.to_s) if output?
      end

      # Send the view to the renderers. If the output is a
      # {Vedeu::Cells::Escape} object (typical when showing or
      # hiding the cursor) then we bypass the
      # {Vedeu::Buffers::Terminal} and write directly to the terminal
      # because escape sequences only make sense to the terminal and
      # not other renderers.
      #
      # @return [Array<String>|String|NilClass]
      # @see #buffer_write
      # @see #direct_write
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

      private

      # @return [Boolean]
      def output?
        present?(output)
      end

    end # Output

  end # Output

  # @api public
  # @!method buffer_update
  # @see file:docs/dsl/by_method/buffer_update.md
  def_delegators Vedeu::Output::Output, :buffer_update

  # @api public
  # @!method buffer_write
  # @see file:docs/dsl/by_method/buffer_write.md
  def_delegators Vedeu::Output::Output, :buffer_write

  # @api public
  # @!method direct_write
  # @see file:docs/dsl/by_method/direct_write.md
  def_delegators Vedeu::Output::Output, :direct_write

  # @api public
  # @!method render_output
  # @see file:docs/dsl/by_method/render_output.md
  def_delegators Vedeu::Output::Output, :render_output

end # Vedeu
