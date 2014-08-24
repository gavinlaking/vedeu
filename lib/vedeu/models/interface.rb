module Vedeu
  class Interface

    extend Forwardable

    def_delegators :geometry, :north, :east, :south, :west,
                              :top, :right, :bottom, :left,
                              :width, :height, :origin,
                              :viewport_width, :viewport_height

    # @param  attributes [Hash]
    # @param  block [Proc]
    # @return [Hash]
    def self.build(attributes = {}, &block)
      new(attributes, &block).attributes
    end

    # @param  attributes [Hash]
    # @param  block [Proc]
    # @return [Interface]
    def initialize(attributes = {}, &block)
      @attributes = attributes

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # @return [Hash]
    def attributes
      @_attributes ||= defaults.merge!(@attributes)
    end

    # @return [String]
    def name
      attributes[:name]
    end

    # @return [String]
    def group
      attributes[:group]
    end

    # @return [Array]
    def lines
      @lines ||= Attributes.coercer(attributes[:lines], Line, :streams)
    end

    # @return [Colour]
    def colour
      @colour ||= Colour.new(attributes[:colour])
    end

    # @return [String]
    def style
      @style ||= Attributes.coerce_styles(attributes[:style])
    end

    # @return [Geometry]
    def geometry
      @geometry ||= Geometry.new(attributes[:geometry])
    end

    # @return [String]
    def cursor
      @cursor ||= if cursor?
        Esc.string('show_cursor')

      else
        Esc.string('hide_cursor')

      end
    end

    # @return [Float]
    def delay
      attributes[:delay]
    end

    # @return [String]
    def to_s
      Render.call(self)
    end

    # @return [String]
    def clear
      Clear.call(self)
    end

    private

    def cursor?
      attributes[:cursor] == true
    end

    def defaults
      {
        name:     '',
        group:    '',
        lines:    [],
        colour:   {},
        style:    '',
        geometry: {},
        cursor:   true,
        delay:    0.0
      }
    end

  end
end
