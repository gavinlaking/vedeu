module Vedeu
  class Interface
    include Coercions
    include Presentation

    extend Forwardable

    def_delegators :geometry, :north, :east, :south, :west,
                              :top, :right, :bottom, :left,
                              :width, :height, :origin,
                              :viewport_width, :viewport_height

    attr_reader :attributes, :delay, :group, :name

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
      @attributes = defaults.merge!(attributes)

      @name  = @attributes[:name]
      @group = @attributes[:group]
      @delay = @attributes[:delay]

      if block_given?
        @self_before_instance_eval = eval('self', block.binding)

        instance_eval(&block)
      end
    end

    # @return [Array]
    def lines
      @lines ||= Line.coercer(attributes[:lines])
    end

    # @return [Geometry]
    def geometry
      @geometry ||= Geometry.new(attributes[:geometry])
    end

    # @return [String]
    def cursor
      @cursor ||= if attributes[:cursor] == true
        Esc.string('show_cursor')

      else
        Esc.string('hide_cursor')

      end
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
