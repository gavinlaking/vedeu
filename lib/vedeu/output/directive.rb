module Vedeu
  class InvalidDirective < StandardError; end

  class Directive
    class << self
      def enact(interface, directives = {})
        new(interface, directives).enact
      end
    end

    def initialize(interface, directives = {})
      @interface  = interface
      @directives = directives || {}
    end

    def enact
      [set_position, set_colour, set_style, set_text].join
    end

    private

    attr_reader :interface, :directives

    def set_position
      Position.set(*position)
    end

    def set_colour
      Colour.set(colour) unless colour.empty?
    end

    def set_style
      Array(style).map { |s| Style.set(s) }.join
    end

    def set_text
      Wordwrap.this(text, options)
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

    def text
      directives.fetch(:text, '')
    end

    def options
      {
        width: interface.geometry.width,
        prune: true
      }
    end
  end
end
