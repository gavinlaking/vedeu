module Vedeu
  class InvalidDirective < StandardError; end

  class Directive
    class << self
      def enact(directives = {})
        new(directives).enact
      end
    end

    def initialize(directives = {})
      @directives = directives || {}
    end

    def enact
      return directives if string?
      [set_position, set_colour, set_style].join
    end

    private

    attr_reader :directives

    def string?
      directives.is_a?(String)
    end

    def set_position
      Position.set(*position)
    end

    def set_colour
      Colour.set(colour)
    end

    def set_style
      Array(style).map { |s| Style.set(s) }.join
    end

    def position
      directives.fetch(:position, [])
    end

    def colour
      directives.fetch(:colour, [])
    end

    def style
      directives.fetch(:style, [])
    end
  end
end
