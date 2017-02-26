# frozen_string_literal: true

module Vedeu

  module Cursors

    # Crudely corrects out of range values.
    #
    # @api private
    #
    class Coordinate

      extend Forwardable

      def_delegators :coordinate,
                     :d,
                     :bd,
                     :bdn,
                     :d_dn

      # Return a new instance of Vedeu::Cursors::Coordinate.
      #
      # @param attributes [Hash<Symbol => Integer|String|Symbol>]
      # @option attributes geometry [Vedeu::Geometries::Geometry]
      # @option attributes type [Symbol]
      # @option attributes offset [Integer]
      # @return [Vedeu::Cursors::Coordinate]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # Returns the maximum coordinate for an area.
      #
      # @example
      #   # d = 2
      #   # d_dn = 4 # represents width or height
      #   dn # => 6
      #
      # @return [Integer]
      def dn_position
        return 0 if d_dn <= 0

        d + d_dn
      end
      alias xn dn_position
      alias yn dn_position

      # Returns the coordinate for a given index.
      #
      # @example
      #   # d_range = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
      #   position     # => 4
      #   position(-2) # => 4
      #   position(2)  # => 6
      #   position(15) # => 13
      #
      # @return [Integer]
      def d_position
        Vedeu::Point.coerce(value: position, min: bd, max: bdn).value
      end
      alias x d_position
      alias y d_position

      protected

      # @!attribute [r] geometry
      # @return [Vedeu::Geometries::Geometry]
      attr_reader :geometry

      # @!attribute [r] offset
      # @return [Integer]
      attr_reader :offset

      # @!attribute [r] type
      # @return [Symbol]
      attr_reader :type

      private

      # @macro raise_invalid_syntax
      # @return [Vedeu::XCoordinate|Vedeu::YCoordinate]
      def coordinate
        @_coordinate ||= case type
                         when :x then Vedeu::XCoordinate.new(geometry)
                         when :y then Vedeu::YCoordinate.new(geometry)
                         else
                           raise Vedeu::Error::InvalidSyntax,
                                 'Coordinate type not given, cannot continue.'
                         end
      end

      # Returns the maximum index for an area.
      #
      # @example
      #   # d_dn = 3
      #   dn_index # => 2
      #
      # @return [Integer]
      def dn_index
        return 0 if d_dn < 1

        d_dn - 1
      end

      # Returns an array with all coordinates from d to dn.
      #
      # @example
      #   # d_dn = 10
      #   # d = 4
      #   # dn = 14
      #   d_range # => [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
      #
      # @return [Array]
      def d_range
        (d...dn_position).to_a
      end

      # @macro defaults_method
      def defaults
        {
          geometry: nil,
          offset:   nil,
          type:     :x,
        }
      end

      # Return the position respective of the offset.
      #
      # @return [Integer]
      def position
        if offset <= 0
          d

        elsif offset > dn_index
          dn_position

        else
          d_range[offset]

        end
      end

    end # Coordinate

  end # Cursors

end # Vedeu
