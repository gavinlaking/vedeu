module Vedeu
  module Buffer
    module Formatting
      include Virtus.module

      attribute :style,      Vedeu::Buffer::Style
      attribute :foreground, Symbol
      attribute :background, Symbol

      private

      def colour
        return [] if foreground.nil? || background.nil?

        [foreground, background]
      end

      def styles
        return [] if style.nil?

        style
      end
    end
  end
end
