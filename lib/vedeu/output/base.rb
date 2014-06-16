module Vedeu
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
      [Esc.esc, prefix, code, suffix].join
    end

    private

    attr_reader :colour

    def prefix
      named? || default? ? normal : custom
    end

    def code
      no_colour || named || html || default
    end

    def no_colour
      default unless colour
    end

    def default?
      colour.nil? || colour == :default
    end

    def named
      codes[colour] || codes[:default] if named?
    end

    def named?
      colour.is_a?(Symbol)
    end

    def html
      Translator.translate(colour)
    end

    def default
      codes[:default]
    end

    def suffix
      'm'
    end
  end
end
