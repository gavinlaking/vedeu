module Vedeu

  module Buffers

    # Allow the creation of individual named buffers for views.
    #
    # @api private
    #
    class View

      # Returns a new instance of Vedeu::Buffers::View.
      #
      # @param attributes [Hash<Symbol => NilClass|String|Symbol]
      # @option attributes name [NilClass|String|Symbol]
      # @return [Vedeu::Buffers::View]
      def initialize(attributes = {})
        defaults.merge!(attributes).each do |key, value|
          instance_variable_set("@#{key}", value || defaults.fetch(key))
        end
      end

      private

      # @return [Vedeu::Borders::Border]
      def border
        Vedeu.borders.by_name(name)
      end

      # @return [Vedeu::Buffers::Empty]
      def buffer
        @_buffer ||= Vedeu::Buffers::Empty.new(height: border.height,
                                               name:   name,
                                               width:  border.width).buffer
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
