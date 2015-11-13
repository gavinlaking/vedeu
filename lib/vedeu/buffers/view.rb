module Vedeu

  module Buffers

    class View

      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      private

      def border
        Vedeu.borders.by_name(name)
      end

      def buffer
        @_buffer ||= Vedeu::Buffers::Empty.new(height: border.height,
                                               name:   name,
                                               width:  border.width).buffer
      end

      def current
        @current ||= buffer
      end

      def current_reset!
        @current = buffer
      end

      def defaults
        {
          name: ''
        }
      end

      def dirty
        @dirty ||= buffer
      end

      def dirty_reset!
        @dirty = buffer
      end

    end # View

  end # Buffers

end # Vedeu
