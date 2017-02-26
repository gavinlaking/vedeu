# frozen_string_literal: true

module Vedeu

  module Buffers

    # Allow the creation of individual named buffers for views.
    #
    # @api private
    #
    class View

      extend Forwardable
      include Enumerable
      include Vedeu::Repositories::Defaults

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
      # @macro param_block
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
        Array(value_or_values).flatten.each do |value|
          write(value) if positionable?(value)
        end

        self
      end

      protected

      # @!attribute [r] name
      # @macro return_name
      attr_reader :name

      private

      # @param value [void]
      # @return [Integer]
      def column(value)
        Vedeu::Point.coerce(value: value.position.x, min: bx, max: bxn).value
      end

      # @return [Array<Vedeu::Cells::Empty>]
      def current
        @current ||= Vedeu::Buffers::Empty.new(height: bordered_height,
                                               name:   name,
                                               width:  bordered_width,
                                               x:      bx,
                                               y:      by).buffer
      end

      # @macro defaults_method
      def defaults
        {
          name: nil,
        }
      end

      # @macro geometry_by_name
      def geometry
        @_geometry ||= Vedeu.geometries.by_name(name)
      end

      # @param value [void]
      # @return [Integer]
      def row(value)
        Vedeu::Point.coerce(value: value.position.y, min: by, max: byn).value
      end

      # Write the value into the respective cell as defined by the
      # position attribute.
      #
      # @param value [void]
      # @return [NilClass|void]
      def write(value)
        current[row(value)][column(value)] = value
      end

    end # View

  end # Buffers

end # Vedeu
