module Vedeu

  module Output

    # Write a string directly to the terminal at defined coordinates.
    #
    class Direct

      # @param (see #initialize)
      # @return [String]
      def self.write(value:, x:, y:)
        new(value: value, x: x, y: y).write
      end

      # Returns a new instance of Vedeu::Output::Direct.
      #
      # @param value [String]
      # @param x [Fixnum]
      # @param y [Fixnum]
      # @return [Vedeu::Output::Direct]
      def initialize(value:, x:, y:)
        @value = value || ''
        @x     = x || 1
        @y     = y || 1
      end

      # @return [String]
      def write
        Vedeu.log(type:    :output,
                  message: 'Directly writing output to terminal.')
        Vedeu::Terminal.output(output)

        output
      end

      protected

      # @attribute [r] value
      # @return [String]
      attr_reader :value

      # @attribute [r] x
      # @return [Fixnum]
      attr_reader :x

      # @attribute [r] y
      # @return [Fixnum]
      attr_reader :y

      private

      # @return [String]
      def output
        @output ||= (Array(position) + Array(value)).join
      end

      # @return [String]
      def position
        Vedeu::Geometry::Position.new(y, x).to_s
      end

    end # Direct

  end # Output

end # Vedeu
