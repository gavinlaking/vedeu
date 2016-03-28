# frozen_string_literal: true

module Vedeu

  module Output

    # Directly write to the terminal.
    #
    # @example
    #   Vedeu.write(output, options)
    #
    # @api private
    #
    class Write

      include Vedeu::Presentation
      include Vedeu::Presentation::Colour
      include Vedeu::Presentation::Position
      include Vedeu::Presentation::Styles

      # @api public
      # @param (see #initialize)
      # @return (see #write)
      def self.write(output = nil, options = {})
        new(output, options).write
      end

      # Returns a new instance of Vedeu::Output::Write.
      #
      # @param output [String]
      # @param options [Hash<Symbol => Fixnum>]
      # @option x [Fixnum]
      # @option y [Fixnum]
      # @option colour [Hash<Symbol => String>]
      # @option style [Array<Symbol>|Symbol]
      # @return [Vedeu::Output::Write]
      def initialize(output = nil, options = {})
        @output  = output
        @options = options
        @colour  = options[:colour]
        @style   = options[:style]
      end

      # @return [NilClass]
      def parent
        nil
      end

      # @return [NilClass|Vedeu::Geometries::Position]
      def position(pos = position_start)
        Vedeu::Geometries::Position.coerce(pos)
      end

      # @return [Array<String>]
      def write
        Vedeu.direct_write(to_s)

        to_s
      end

      protected

      # @!attribute [r] output
      # @return [String]
      attr_reader :output
      alias value output

      private

      # @macro defaults_method
      def defaults
        {
          x: 1,
          y: 1,
        }
      end

      # @return [Hash<Symbol => Fixnum>]
      def options
        defaults.merge!(@options)
      end
      alias attributes options

      # @return [String]
      def output
        @output.to_s
      end

      # @return [Hash<Symbol => Fixnum>]
      def position_start
        {
          x: options[:x],
          y: options[:y],
        }
      end

      # @return [Hash<Symbol => Fixnum>]
      def position_end
        {
          x: options[:x] + output.size,
          y: options[:y],
        }
      end

      # @return [String]
      def to_s
        @_to_s ||= super + Vedeu.esc.reset + position(position_end)
      end
      alias to_str to_s

    end # Write

  end # Output

  # @api public
  # @!method write
  #   @see Vedeu::Output::Write#write
  def_delegators Vedeu::Output::Write,
                 :write

end # Vedeu
