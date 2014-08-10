require 'forwardable'
require 'virtus'

require 'vedeu'
require 'vedeu/models/attributes/line_collection'
require 'vedeu/models/colour'
require 'vedeu/models/style'
require 'vedeu/output/clear'
require 'vedeu/output/render'
require 'vedeu/models/geometry'
require 'vedeu/support/terminal'

# Todo: mutation (events, current)

module Vedeu
  class Interface
    extend Forwardable
    include Virtus.model

    attribute :name,     String
    attribute :group,    String
    attribute :lines,    LineCollection
    attribute :colour,   Colour,   default: Colour.new
    attribute :style,    Style,    default: ''
    attribute :geometry, Geometry, default: Geometry.new
    attribute :current,  String,   default: ''
    attribute :cursor,   Boolean,  default: true
    attribute :delay,    Float,    default: 0
    attribute :buffer,   Array,    default: []

    def_delegators :@geometry, :north, :east, :south, :west,
                               :top, :right, :bottom, :left,
                               :width, :height

    def initialize(attributes = {})
      super

      Vedeu.events.on(:_refresh_, self.delay)                 { refresh }
      Vedeu.events.on("_refresh_#{name}_".to_sym, self.delay) { refresh }

      unless group.nil? || group.empty?
        Vedeu.events.on("_refresh_group_#{group}_".to_sym, self.delay) do
          refresh
        end
      end

      self
    end

    def clear
      @_clear ||= Clear.call(self)
    end

    def dequeue
      buffer.pop
    end

    def enqueue
      buffer.unshift(self.to_s)
    end

    def refresh
      if buffer.any?
        self.current = buffer.pop

      elsif no_content?
        self.current = clear

      else
        self.current

      end
      Terminal.output(self.current)

      self.current
    end

    def to_s
      Render.call(self)
    end

    private

    def no_content?
      self.current.nil? || self.current.empty?
    end
  end
end
