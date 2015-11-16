module Vedeu

  module Buffers

    # Allow the creation of individual named buffers for views.
    #
    # @api private
    #
    class View

      include Vedeu::Repositories::Defaults
      include Enumerable

      # @return [Hash<Symbol => String|Symbol>]
      def attributes
        {
          name: name
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

      # @param value_or_values [Array<Array<Vedeu::Views::Char>>|
      #   Vedeu::Views::Char]
      # @return [Vedeu::Buffers::View]
      def update(value_or_values)
        Array(value_or_values).flatten.each do |value|
          if valid?(value)
            current[value.position.y][value.position.x] = value
            dirty << value.position.to_a
          end
        end

        self
      end

      protected

      # @!attribute [r] name
      # @return [String|Symbol]
      attr_reader :name

      private

      # @return [Vedeu::Buffers::Empty]
      def buffer
        @_buffer ||= Vedeu::Buffers::Empty
                       .new(height: geometry.bordered_height,
                            name:   name,
                            width:  geometry.bordered_width).buffer
      end

      # @return [Array<Vedeu::Models::Cell>]
      def current
        @current ||= buffer
      end

      # @return [Vedeu::Buffers::Empty]
      def current_reset!
        @current = buffer
      end

      # @return [Hash<Symbol => NilClass|String|Symbol]
      def defaults
        {
          name: ''
        }
      end

      # @return [Vedeu::Buffers::Empty]
      def dirty
        @dirty ||= []
      end

      # @return [Vedeu::Buffers::Empty]
      def dirty_reset!
        @dirty = []
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
        valid_value?(value) && valid_position?(value)
      end

      # Returns a boolean indicating whether the position of the value
      # object is valid for this terminal.
      #
      # @param value [void]
      # @return [Boolean]
      def valid_position?(value)
        buffer[value.position.y] && buffer[value.position.y][value.position.x]
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

    end # View

  end # Buffers

end # Vedeu
