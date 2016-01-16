# frozen_string_literal: true

module Vedeu

  module Cursors

    # Crudely corrects out of range values.
    #
    # @api private
    #
    class Coordinate

      # Return a new instance of Vedeu::Cursors::Coordinate.
      #
      # @param attributes [Hash<Symbol => Fixnum|String|Symbol>]
      # @option attributes name [String|Symbol]
      # @option attributes type [Symbol]
      # @option attributes offset [Fixnum]
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
      # @return [Fixnum]
      def dn_position
        return 0 if d_dn <= 0

        d + d_dn
      end
      alias_method :xn, :dn_position
      alias_method :yn, :dn_position

      # Returns the coordinate for a given index.
      #
      # @example
      #   # d_range = [4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
      #   position     # => 4
      #   position(-2) # => 4
      #   position(2)  # => 6
      #   position(15) # => 13
      #
      # @return [Fixnum]
      def d_position
        pos = if offset <= 0
                d

              elsif offset > dn_index
                dn_position

              else
                d_range[offset]

              end

        Vedeu::Point.coerce(value: pos, min: bd, max: bdn).value
      end
      alias_method :x, :d_position
      alias_method :y, :d_position

      protected

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      # @!attribute [r] offset
      # @return [Fixnum]
      attr_reader :offset

      # @!attribute [r] type
      # @return [Symbol]
      attr_reader :type

      private

      # Returns the geometry for the interface.
      #
      # @return (see Vedeu::Geometries::Repository#by_name)
      def geometry
        @geometry ||= Vedeu.geometries.by_name(name)
      end

      # Return the :x or :y value from the geometry.
      #
      # @return [Fixnum]
      def d
        geometry.send(coordinate_type[0])
      end

      # Return the :bx or :by value from the geometry.
      #
      # @return [Fixnum]
      def bd
        geometry.send(coordinate_type[1])
      end

      # Return the :bxn or :byn value from the geometry.
      #
      # @return [Fixnum]
      def bdn
        geometry.send(coordinate_type[2])
      end

      # Return the :width or :height value from the geometry.
      #
      # @return [Fixnum]
      def d_dn
        geometry.send(coordinate_type[3])
      end

      # Ascertain the correct methods to use for determining the
      # coordinates.
      #
      # @macro raise_invalid_syntax
      # @return [Fixnum]
      def coordinate_type
        @_type ||= case type
                   when :x then [:x, :bx, :bxn, :bordered_width]
                   when :y then [:y, :by, :byn, :bordered_height]
                   else
                     fail Vedeu::Error::InvalidSyntax,
                          'Coordinate type not given, cannot continue.'
                   end
      end

      # Returns the maximum index for an area.
      #
      # @example
      #   # d_dn = 3
      #   dn_index # => 2
      #
      # @return [Fixnum]
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

      # The default values for a new instance of this class.
      #
      # @return [Hash<Symbol => Fixnum|String|Symbol>]
      def defaults
        {
          name:   '',
          offset: nil,
          type:   :x,
        }
      end

    end # Coordinate

  end # Cursors

end # Vedeu
