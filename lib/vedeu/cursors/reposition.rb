# frozen_string_literal: true

module Vedeu

  module Cursors

    # Arbitrarily move the cursor to a given position.
    #
    # @api private
    #
    class Reposition

      # Returns a new instance of Vedeu::Cursors::Reposition.
      #
      # @param attributes [Hash<Symbol => Fixnum|Symbol|String]
      # @option attributes mode [Symbol] One of either :absolute or
      #   :relative. Relates to the coordinates provided.
      # @option attributes name [String|Symbol] The name of the cursor
      #   and related interface/view.
      # @option attributes x [Fixnum] The new row/line position.
      # @option attributes y [Fixnum] The new column/character
      #   position.
      # @return [Vedeu::Cursors::Reposition]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value)
        end
      end

      # @return [Vedeu::Cursors::Cursor]
      def reposition
        Vedeu::Cursors::Cursor.store(new_attributes) do
          Vedeu.trigger(:_refresh_cursor_, name)
        end
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      # @!attribute [r] x
      # @return [Fixnum]
      attr_reader :x

      # @!attribute [r] y
      # @return [Fixnum]
      attr_reader :y

      private

      # @return [Hash<Symbol => Fixnum>]
      def absolute
        {
          x:  coordinate((x - geometry.x), :x).x,
          y:  coordinate((y - geometry.y), :y).y,
          ox: 0,
          oy: 0,
        }
      end

      # @return [Boolean]
      def absolute?
        mode == :absolute
      end

      # Determine correct x and y related coordinates.
      #
      # @param offset [Fixnum]
      # @param type [Symbol]
      # @return [Vedeu::Cursors::Coordinate]
      def coordinate(offset, type)
        Vedeu::Cursors::Coordinate.new(geometry: geometry,
                                       offset:   offset,
                                       type:     type)
      end

      # @return [Vedeu::Cursors::Cursor]
      def cursor
        Vedeu.cursors.by_name(name)
      end

      # @macro defaults_method
      def defaults
        {
          mode: :relative,
          name: Vedeu.focus,
          x:    0,
          y:    0,
        }
      end

      # @macro geometry_by_name
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # @return [Boolean]
      def inside_geometry?
        x >= geometry.x &&
          x <= geometry.xn &&
          y >= geometry.y &&
          y <= geometry.yn
      end

      # @return [Symbol]
      def mode
        @mode = if modes.include?(@mode)
                  @mode

                else
                  defaults[:mode]

                end
      end

      # Positioning is handled either with absolute or relative
      # coordinates, the coordinates are checked against the geometry
      # of the interface/view and altered to reside within the
      # boundary defined.
      #
      # @return [Array<Symbol>]
      def modes
        [:relative, :absolute]
      end

      # @return [Hash<Symbol => Fixnum>]
      def new_attributes
        if absolute? && inside_geometry?
          cursor.attributes.merge!(absolute)

        elsif relative?
          cursor.attributes.merge!(relative)

        else
          cursor.attributes

        end
      end

      # @return [Hash<Symbol => Fixnum>]
      def relative
        {
          x:  coordinate(x, :x).x,
          y:  coordinate(y, :y).y,
          ox: x,
          oy: y,
        }
      end

      # @return [Boolean]
      def relative?
        mode == :relative
      end

    end # Reposition

  end # Cursors

end # Vedeu
