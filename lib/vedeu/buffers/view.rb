# frozen_string_literal: true

module Vedeu

  module Buffers

    # Allow the creation of individual named buffers for views.
    #
    # @api private
    #
    class View

      include Vedeu::Repositories::Defaults
      include Enumerable
      extend Forwardable

      def_delegators :geometry,
                     :bordered_height,
                     :bordered_width,
                     :bx,
                     :by,
                     :byn,
                     :bxn

      # @return [Hash<Symbol => String|Symbol>]
      def attributes
        {
          name: name,
        }
      end

      # Provides iteration over the buffer.
      #
      # @param block [Proc]
      # @return [Enumerator]
      def each(&block)
        current.each(&block)
      end

      # Resets the named view buffer back to its empty state.
      #
      # @return [Vedeu::Buffers::View]
      def reset!
        Vedeu::Buffers::View.new(attributes)
      end

      # @param value_or_values [Array<Array<Vedeu::Cells::Char>>|
      #   Vedeu::Cells::Char]
      # @return [Vedeu::Buffers::View]
      def update(value_or_values)
        Array(value_or_values).flatten.each { |value| write(value) }

        self
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      private

      # @return [Array<Vedeu::Cells::Empty>]
      def current
        @current ||= Vedeu::Buffers::Empty.new(height: bordered_height,
                                               name:   name,
                                               width:  bordered_width,
                                               x:      bx,
                                               y:      by).buffer
      end

      # @return [Hash<Symbol => NilClass|String|Symbol]
      def defaults
        {
          name: nil,
        }
      end

      # @return [Vedeu::Geometries::Geometry]
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # Returns a boolean indicating the value has a position
      # attribute and is within the terminal boundary.
      #
      # @param value [void]
      # @return [Boolean]
      def valid?(value)
        valid_value?(value)        &&
        valid_y?(value.position.y) &&
        valid_x?(value.position.x)
      end

      # Returns a boolean indicating the value has a position
      # attribute.
      #
      # @param value [void]
      # @return [Boolean]
      def valid_value?(value)
        value.respond_to?(:position) &&
          value.position.is_a?(Vedeu::Geometries::Position)
      end

      # Returns a boolean indicating whether the x position of the
      # value object is valid for this geometry.
      #
      # @return [Boolean]
      def valid_x?(x)
        Vedeu::Point.valid?(value: x, min: bx, max: bxn)
      end

      # Returns a boolean indicating whether the y position of the
      # value object is valid for this geometry.
      #
      # @return [Boolean]
      def valid_y?(y)
        Vedeu::Point.valid?(value: y, min: by, max: byn)
      end

      # Write the value into the respective cell as defined by the
      # position attribute.
      #
      # @param value [void]
      # @return [NilClass|void]
      def write(value)
        current[value.position.y][value.position.x] = value if valid?(value)
      end

    end # View

  end # Buffers

end # Vedeu
