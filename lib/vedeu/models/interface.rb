require 'virtus'

require 'vedeu'
require 'vedeu/models/attributes/line_collection'
require 'vedeu/models/colour'
require 'vedeu/models/style'
require 'vedeu/output/clear_interface'
require 'vedeu/output/render_interface'
require 'vedeu/models/geometry'
require 'vedeu/support/queue'
require 'vedeu/support/terminal'

# Todo: mutation (events, current)

module Vedeu
  class Interface
    include Vedeu::Queue
    include Virtus.model

    attribute :name,     String
    attribute :lines,    LineCollection
    attribute :colour,   Colour,   default: Colour.new
    attribute :style,    Style,    default: ''
    attribute :geometry, Geometry, default: Geometry.new
    attribute :current,  String,   default: ''
    attribute :cursor,   Boolean,  default: true
    attribute :delay,    Float,    default: 0

    def initialize(attributes = {})
      super

      Vedeu.events.on(:refresh, self.delay) { refresh }

      self
    end

    def clear
      @_clear ||= ClearInterface.call(self)
    end

    def enqueue
      super(self.to_s)
    end

    def refresh
      if enqueued?
        self.current = dequeue

      elsif no_content?
        self.current = clear

      else
        self.current

      end
      Terminal.output(self.current)

      self.current
    end

    def to_s
      RenderInterface.call(self)
    end

    private

    def no_content?
      self.current.nil? || self.current.empty?
    end
  end
end
