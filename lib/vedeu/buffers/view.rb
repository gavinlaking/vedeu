module Vedeu

  module Buffers

    # Allow the creation of individual named buffers for views.
    #
    # @api private
    #
    class View

      include Vedeu::Repositories::Defaults

      private

      # @return [Vedeu::Geometries::Geometry]
      def geometry
        Vedeu.geometries.by_name(name)
      end

      # @return [Vedeu::Buffers::Empty]
      def buffer
        @_buffer ||= Vedeu::Buffers::Empty
                       .new(height: geometry.bordered_height,
                            name:   name,
                            width:  geometry.bordered_width).buffer
      end

      # @return [Vedeu::Buffers::Empty]
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
        @dirty ||= buffer
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
