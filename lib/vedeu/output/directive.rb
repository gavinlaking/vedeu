module Vedeu
  class InvalidDirective < StandardError; end

  class Directive
    class << self
      def enact(directive)
        new(directive).enact
      end
    end

    def initialize(directive)
      @directive = directive
    end

    def enact
      raise InvalidDirective unless valid_directive?

      return style    if style?
      return position if position?
      return colour   if colour?
    end

    private

    attr_reader :directive

    def style?
      directive.is_a?(Symbol)
    end

    def style
      Style.set(directive)
    end

    def position?
      directive.is_a?(Array) && directive.first.is_a?(Numeric)
    end

    def position
      Position.set(*directive)
    end

    def colour?
      directive.is_a?(Array) && directive.first.is_a?(Symbol)
    end

    def colour
      Colour.set(directive)
    end

    def valid_directive?
      directive.is_a?(Array) || directive.is_a?(Symbol)
    end
  end
end
