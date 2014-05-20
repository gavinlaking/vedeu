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

      if directive.is_a?(Array)
        if directive.first.is_a?(Numeric)
          Position.set(*directive)
        elsif directive.first.is_a?(Symbol)
          Colour.set(directive)
        end
      elsif directive.is_a?(Symbol)
        Style.use(directive)
      end
    end

    private

    attr_reader :directive

    def valid_directive?
      directive.is_a?(Array) || directive.is_a?(Symbol)
    end
  end
end
