module Vedeu
  module Buffer
    module Formatting
      include Virtus.module

      attribute :style,      Vedeu::Buffer::Style
      attribute :foreground, Symbol
      attribute :background, Symbol

      private

      def colour
        if foreground && background
          [foreground, background]
        elsif foreground.nil? || background.nil?
          []
        end
      end

      def styles
        if style
          style
        elsif style.nil?
          []
        end
      end
    end
  end
end
