require 'virtus'

require_relative 'presentation'
require_relative 'line_collection'
require_relative '../support/esc'
require_relative '../support/cursor'
require_relative '../support/queue'
require_relative '../support/terminal'

module Vedeu
  class Interface
    include Virtus.model
    include Presentation
    include Vedeu::Queue

    attribute :name,    String
    attribute :lines,   LineCollection
    attribute :y,       Integer, default: 1
    attribute :x,       Integer, default: 1
    attribute :z,       Integer, default: 1
    attribute :width,   Integer, default: Terminal.width
    attribute :height,  Integer, default: Terminal.height
    attribute :current, String,  default: ''
    attribute :cursor,  Boolean, default: true

    def clear(index = 0)
      [origin(index), (' ' * width), origin(index)].join
    end

    def dy
      if clip_y?
        defaults[:height]

      else
        (y + height)

      end
    end

    def dx
      if clip_x?
        defaults[:width]

      else
        (x + width)

      end
    end

    def origin(index = 0)
      Esc.set_position(virtual_y(index), virtual_x)
    end

    def refresh
      if enqueued?
        current = dequeue

      elsif current.nil? || current.empty?
        current = clear_interface

      else
        current

      end
    end

    def to_json
      Oj.dump(attributes, mode: :compat)
    end

    def to_s
      [
        clear_interface,
        origin,
        colour.to_s,
        lines.map(&:to_s)
      ].join
    end

    def virtual_x(index = 0)
      ((x..dx).to_a)[index]
    end

    def virtual_y(index = 0)
      ((y..dy).to_a)[index]
    end

    private

    def clear_interface
      [
        colour.to_s,
        height.times.inject([]) { |acc, i| acc << clear(i) }
      ].join
    end

    def clip_y?
      ((y + height) > defaults[:height])
    end

    def clip_x?
      ((x + width) > defaults[:width])
    end

    def defaults
      {
        width:  Terminal.width,
        height: Terminal.height
      }
    end
  end
end
