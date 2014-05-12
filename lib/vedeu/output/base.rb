module Vedeu
  module Output
    class Base
      class << self
        def escape_sequence(colour = nil)
          new(colour).escape_sequence
        end
      end

      def initialize(colour = nil)
        @colour = colour
      end

      def escape_sequence
        [esc, prefix, code, suffix].join
      end

      private

      attr_reader :colour

      def code
        no_colour || named || html || default
      end

      def no_colour
        default unless colour
      end

      def named
        codes[colour] || codes[:default] if named?
      end

      def named?
        colour.is_a?(Symbol)
      end

      def html
        Output::Translator.translate(colour)
      end

      def default
        codes[:default]
      end

      def esc
        Esc.esc
      end

      def suffix
        'm'
      end
    end
  end
end
