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

      return Style.set(directive) if directive.is_a?(Symbol)

      if directive.is_a?(Array)
        return Position.set(*directive) if directive.first.is_a?(Numeric)
        return Colour.set(directive)    if directive.first.is_a?(Symbol)
      end
    end

    private

    attr_reader :directive

    def valid_directive?
      directive.is_a?(Array) || directive.is_a?(Symbol)
    end
  end
end
