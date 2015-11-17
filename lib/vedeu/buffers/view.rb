module Vedeu

  module Buffers

    # Allow the creation of individual named buffers for views.
    #
    # @api private
    #
    class View

      include Vedeu::Repositories::Defaults

      private

      # @return [Vedeu::Geometry::Geometry]
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
        @dirty = buffer
      end

    end # View

  end # Buffers

end # Vedeu
